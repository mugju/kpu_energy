import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:typed_data/typed_buffers.dart' show Uint8Buffer;

class MachineControl extends StatefulWidget {
  MachineControl({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MachineControlState createState() => _MachineControlState();
}

class _MachineControlState extends State<MachineControl> {
  String broker = 'elijah.iptime.org';
  int port = 1883;
  String clientIdentifier = 'android-turma124';
  String smp_topic = 'Smplug1';

  String smp_elec_topic = 'Smplug1_elec';

  late mqtt.MqttClient client;
  late mqtt.MqttConnectionState connectionState;

  //초기 값
  double _temp = 0;
  double _smplug_amp = 0;

  late StreamSubscription subscription;

  /*
  Conecta no servidor MQTT assim que inicializar a tela
   */
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _connect());
  }

  /*
  Assina o t?pico onde vir?o os dados de temperatura
   */
  void _subscribeToTopic(String topic) {
    if (connectionState == mqtt.MqttConnectionState.connected) {
      print('[MQTT client] Subscribing to ${topic.trim()}');
      print('[MQTT client] topic data : ${topic.characters}');
      client.subscribe(topic, mqtt.MqttQos.exactlyOnce);
      print('[client connectionStatus]: ${client.connectionStatus}');
      print("");
      print('[client connectionMessage]: ${client.connectionMessage}');
      print("");
      print('[client updates]: ${client.updates}');
      print("");
      print('[client updates]: ${client.getSubscriptionsStatus(topic)}');
      print("");
    }
  }

  /*
  Constroi a tela com o term?metro
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            '[Smart Plug 제어] ',
            style: Theme.of(context).textTheme.headline5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   '[Smart Plug 제어] ',
              //   style: Theme.of(context).textTheme.headline6,
              // ),
              ElevatedButton(
                onPressed: () {
                  publishString('1');
                  print('send 1');
                },
                child: Text('On(1)'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 0.0),
              ),
              ElevatedButton(
                onPressed: () {
                  publishString('0');
                  print('send 0');
                },
                child: Text('Off(0)'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 0.0),
              ),
              const SizedBox(
                width: 20,
              ),

              Text(
                '$_temp',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          Divider(
            // Divider -> 공간을 나누는 선
            height:
                30.0, // height ->  높이 설정 -> 위와 아래 사이의 간격이 합쳐서 60.0 이라는 뜻(위 아래로 각 30px)
            color: Colors.blue[600], // color -> 색상 설정
            thickness: 2, // thickness -> 선의 굵기
            indent: 20.0,
            endIndent: 20.0, // endIndent -> 선이 끝에서 부터 어느정도 떨어질 지 결정하는 속성
          ),
          Text(
            '[Smart Plug 순간 전력] ',
            style: Theme.of(context).textTheme.headline5,
          ),
          // Text(
          //   '[Smart Plug 제어] ',
          //   style: Theme.of(context).textTheme.headline6,
          // ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '$_smplug_amp',
            style: Theme.of(context).textTheme.headline6,
          ),
          Divider(
            // Divider -> 공간을 나누는 선
            height:
                30.0, // height ->  높이 설정 -> 위와 아래 사이의 간격이 합쳐서 60.0 이라는 뜻(위 아래로 각 30px)
            color: Colors.blue[600], // color -> 색상 설정
            thickness: 2, // thickness -> 선의 굵기
            indent: 20.0,
            endIndent: 20.0, // endIndent -> 선이 끝에서 부터 어느정도 떨어질 지 결정하는 속성
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _onoff,
        tooltip: 'Ligar/Desligar',
        child: Icon(Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _onoff() async {
    Uint8Buffer value = Uint8Buffer();
    value.add(1);
    client.publishMessage("professor_onoff", mqtt.MqttQos.exactlyOnce, value);
  }

  /*
  Conecta no servidor MQTT ? partir dos dados configurados nos atributos desta classe (broker, port, etc...)
   */
  void _connect() async {
    client = mqtt.MqttClient(broker, '');
    client.port = port;
    client.keepAlivePeriod = 30;
    client.onDisconnected = _onDisconnected;

    final mqtt.MqttConnectMessage connMess = mqtt.MqttConnectMessage()
        .withClientIdentifier(clientIdentifier)
        .startClean() // Non persistent session for testing
        .keepAliveFor(30)
        .withWillQos(mqtt.MqttQos.atMostOnce);
    print('[MQTT client] MQTT client connecting....');
    client.connectionMessage = connMess;

    try {
      await client.connect();
    } catch (e) {
      print(e);
      _disconnect();
    }

    /// Check if we are connected
    if (client.connectionState == mqtt.MqttConnectionState.connected) {
      print('[MQTT client] connected');
      setState(() {
        connectionState = client.connectionState;
      });
    } else {
      print('[MQTT client] ERROR: MQTT client connection failed - '
          'disconnecting, state is ${client.connectionState}');
      _disconnect();
    }

    _subscribeToTopic(smp_topic);

    client.updates.listen((List<mqtt.MqttReceivedMessage> event) {
      print(event.length);
      final mqtt.MqttPublishMessage recMess =
          event[0].payload as mqtt.MqttPublishMessage;
      final String message = mqtt.MqttPublishPayload.bytesToStringAsString(
          recMess.payload.message);

      print('[MQTT client] MQTT message: topic is <${event[0].topic}>, '
          'payload is <-- ${message} -->');
      print(client.connectionState);
      print("[MQTT client] message with topic: ${event[0].topic}");
      print("[MQTT client] message with message: ${message}");

      setState(() {
        _temp = double.parse(message);
      });
    });



    // _subscribeToTopic(smp_elec_topic);

    // client.updates.listen((List<mqtt.MqttReceivedMessage> event) {
    //   print(event.length);
    //   final mqtt.MqttPublishMessage recMess =
    //       event[0].payload as mqtt.MqttPublishMessage;
    //   final String message = mqtt.MqttPublishPayload.bytesToStringAsString(
    //       recMess.payload.message);

    //   print('[MQTT client] MQTT message: topic is <${event[0].topic}>, '
    //       'payload is <-- ${message} -->');
    //   print(client.connectionState);
    //   print("[MQTT client] message with topic: ${event[0].topic}");
    //   print("[MQTT client] message with message: ${message}");

    //   setState(() {
    //     _smplug_amp = double.parse(message);
    //   });
    // });



    //subscription = client.updates.listen(_onMessage);
  }

  

  /*
  Desconecta do servidor MQTT
   */
  void _disconnect() {
    print('[MQTT client] _disconnect()');
    client.disconnect();
    _onDisconnected();
  }

  /*
  Executa algo quando desconectado, no caso, zera as vari?veis e imprime msg no console
   */
  void _onDisconnected() {
    print('[MQTT client] _onDisconnected');
    setState(() {
      //topics.clear();
      connectionState = client.connectionState;
      //client = null;
      subscription.cancel();
      //subscription = null;
    });
    print('[MQTT client] MQTT client disconnected');
  }

  /*
 mqtt 수정 부분
   */
  void _onMessage(List<mqtt.MqttReceivedMessage> event) {
    print(event.length);
    final mqtt.MqttPublishMessage recMess =
        event[0].payload as mqtt.MqttPublishMessage;
    final String message =
        mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    print('[MQTT client] MQTT message: topic is <${event[0].topic}>, '
        'payload is <-- ${message} -->');
    print(client.connectionState);
    print("[MQTT client] message with topic: ${event[0].topic}");
    print("[MQTT client] message with message: ${message}");
    setState(() {
      _temp = double.parse(message);
    });
  }

  void publishString(String data) {
    /*
         Checks if MQTT is connected and TextInput contains non empty String
    */
    if (client.connectionState == mqtt.MqttConnectionState.connected) {
      final mqtt.MqttClientPayloadBuilder builder =
          mqtt.MqttClientPayloadBuilder();
      builder.addString(data);
      client.publishMessage(
          smp_topic, mqtt.MqttQos.atLeastOnce, builder.payload);
      client.published.listen((mqtt.MqttPublishMessage message) {
        print("[MQTT client] string publilshed on topic->" +
            message.variableHeader.topicName.toString());
        print("[MQTT client] with Qos->" + message.header.qos.toString());
      });
    }
  }
}
