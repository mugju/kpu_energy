import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:typed_data/typed_buffers.dart' show Uint8Buffer;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  String people = 'People';

  String sct = 'SCT013';

  String sct_total = 'Total_power';

  // 5개
  late mqtt.MqttClient client;
  late mqtt.MqttClient client_elec;
  late mqtt.MqttClient client_people;
  late mqtt.MqttClient client_sct;
  late mqtt.MqttClient client_total;

  late mqtt.MqttConnectionState connectionState;

  //초기 값
  String _temp = 'OFF';
  double _smplug_amp = 0;
  String _people = '인원 없음';
  double _SCT_amp = 0;
  double _SCT_total = 0;

  late StreamSubscription subscription;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // 사용자 지정 기준 amp 설정 예정

  /*
  Conecta no servidor MQTT assim que inicializar a tela
   */
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _connect());

    init();
  }

  void init() async {
    // 알림용 ICON 설정
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // 알림 초기화
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      //onSelectNotification은 알림을 선택했을때 발생
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
    });
  }

  // 알림 더미 타이틀
  List<String> pushTitleList = ['ON', 'OFF'];
  // 알림 그룹 ID 카운트용, 알림이 올때마다 이 값을 1씩 증가 시킨다.
  int groupedNotificationCounter = 1;

  // late final String onMessage;
  // late int num = int.parse(onMessage);

  /*
  Assina o t?pico onde vir?o os dados de temperatura
   */
  void _subscribeToTopic(String topic) {
    if (connectionState == mqtt.MqttConnectionState.connected) {
      print('[MQTT client] Subscribing to ${topic.trim()}');
      print('[MQTT client] topic data : ${topic.characters}');
      // 5개 만들기
      client.subscribe(topic, mqtt.MqttQos.exactlyOnce);
      // client_elec.subscribe(topic, mqtt.MqttQos.exactlyOnce);
      // client_people.subscribe(topic, mqtt.MqttQos.exactlyOnce);
      // client_sct.subscribe(topic, mqtt.MqttQos.exactlyOnce);
      // client_total.subscribe(topic, mqtt.MqttQos.exactlyOnce);




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
          Text(
            '[재실 인원 유무] ',
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
            '$_people',
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
          Text(
            '[배전반 순간 전력] ',
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
            '$_SCT_amp',
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
          Text(
            '[배전반 누적 전력] ',
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
            '$_SCT_total',
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

    _subscribeToTopic(smp_elec_topic);

    _subscribeToTopic(people);

    _subscribeToTopic(sct);

    _subscribeToTopic(sct_total);

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
        if (event[0].topic == "Smplug1_elec") {
          _smplug_amp = double.parse(message);
        }
        if (event[0].topic == "Smplug1") {
          if (double.parse(message) == 1 && _temp != 'ON') {
            _temp = 'ON';
            _showGroupedNotifications(_temp);
          } else if (double.parse(message) == 0 && _temp != 'OFF') {
            _temp = 'OFF';
            _showGroupedNotifications(_temp);
          }
        }
        if (event[0].topic == "People") {
          if (double.parse(message) >= 1) {
            _people = '재실중';
          } else {
            _people = '인원 없음';
          }
        }
        if (event[0].topic == "SCT013") {
          _SCT_amp = double.parse(message);
        }
        if(event[0].topic == "Total_power"){
          _SCT_total = double.parse(message);
        }
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
  // void _onMessage(List<mqtt.MqttReceivedMessage> event) {
  //   print(event.length);
  //   final mqtt.MqttPublishMessage recMess =
  //       event[0].payload as mqtt.MqttPublishMessage;
  //   onMessage =
  //       mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
  //   print('[MQTT client] MQTT message: topic is <${event[0].topic}>, '
  //       'payload is <-- ${onMessage} -->');
  //   print(client.connectionState);
  //   print("[MQTT client] message with topic: ${event[0].topic}");
  //   print("[MQTT client] message with message: ${onMessage}");
  //   setState(() {
  //     _showGroupedNotifications();
  //     if (double.parse(onMessage) == 1) {
  //       _temp = 'ON';
  //     } else {
  //       _temp = 'OFF';
  //     }
  //   });
  // }
  // 알림 발생 함수!!
  Future<void> _showGroupedNotifications(String temp) async {
    // 알림 그룹 키
    const String groupKey = 'com.android.example.WORK_EMAIL';
    // 알림 채널
    const String groupChannelId = 'grouped channel id';
    // 채널 이름
    const String groupChannelName = 'grouped channel name';
    // 채널 설명
    const String groupChannelDescription = 'grouped channel description';

    // 더미 타이틀 랜덤으로 얻기위함
    //// 삼항 연산자로 사용은 가능
    //int num = (pushTitleList.length >= 3) ? 0 : 1;

    // 안드로이드 알림 설정
    const AndroidNotificationDetails notificationAndroidSpecifics =
        AndroidNotificationDetails(
            groupChannelId, groupChannelName, groupChannelDescription,
            importance: Importance.max,
            priority: Priority.high,
            groupKey: groupKey);

    // 플랫폼별 설정 - 현재 안드로이드만 적용됨
    const NotificationDetails notificationPlatformSpecifics =
        NotificationDetails(android: notificationAndroidSpecifics);

    // 알림 발생!
    await flutterLocalNotificationsPlugin.show(groupedNotificationCounter, temp,
        '스마트 플러그 작동 상태 - ${temp}', notificationPlatformSpecifics);

    // 그룹용 알림 설정
    // 특징 setAsGroupSummary 가 true 이다.
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            groupChannelId, groupChannelName, groupChannelDescription,
            onlyAlertOnce: true, groupKey: groupKey, setAsGroupSummary: true);

    // 플랫폼별 설정 - 현재 안드로이드만 적용됨
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    // 그룹용 알림 출력
    // 이때는 ID를 0으로 고정시켜 새로 생성되지 않게 한다.
    await flutterLocalNotificationsPlugin.show(
        0, '', '', platformChannelSpecifics);
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
