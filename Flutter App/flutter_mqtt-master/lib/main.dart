import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:typed_data/typed_buffers.dart' show Uint8Buffer;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MachineControl(title: 'App Flutter + IoT + ESP32'),
    );
  }
}

class MachineControl extends StatefulWidget {
  MachineControl({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MachineControlState createState() => _MachineControlState();
}

class _MachineControlState extends State<MachineControl> {
  String broker = 'elijah.iptime.org';
  int port = 1883;
  String clientIdentifier = 'android-turma124';
  String topic = 'Smplug1'; // TROQUE AQUI PARA UM TOPIC EXCLUSIVO SEU

  mqtt.MqttClient client;
  mqtt.MqttConnectionState connectionState;

  //초기 온도
  double _temp = 0;

  StreamSubscription subscription;

  /*
  Conecta no servidor MQTT assim que inicializar a tela
   */
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _connect());
  }

  /*
  Assina o tópico onde virão os dados de temperatura
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
  Constroi a tela com o termômetro
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$_temp',
            style: Theme.of(context).textTheme.headline6,
            ),
          ElevatedButton(
            onPressed: () {
              publishString('1');
              print('send 1');
            },
            child: Text('Send 1 - On'),
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
            child: Text('Send 0 - Off'),
            style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 0.0),
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
  Conecta no servidor MQTT à partir dos dados configurados nos atributos desta classe (broker, port, etc...)
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

    _subscribeToTopic(topic);

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
  Executa algo quando desconectado, no caso, zera as variáveis e imprime msg no console
   */
  void _onDisconnected() {
    print('[MQTT client] _onDisconnected');
    setState(() {
      //topics.clear();
      connectionState = client.connectionState;
      client = null;
      subscription.cancel();
      subscription = null;
    });
    print('[MQTT client] MQTT client disconnected');
  }

  /*
 mqtt에서 받은 값으로 수정 수행하는 부분
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
      client.publishMessage(topic, mqtt.MqttQos.atLeastOnce, builder.payload);
      client.published.listen((mqtt.MqttPublishMessage message) {
        print("[MQTT client] string publilshed on topic->" +
            message.variableHeader.topicName.toString());
        print("[MQTT client] with Qos->" + message.header.qos.toString());
      });
    }
  }
}
