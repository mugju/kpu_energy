import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Notifications Plugin 생성
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    // 알림 초기화
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
  List pushTitleList = ['ON', 'OFF'];
  // 알림 그룹 ID 카운트용, 알림이 올때마다 이 값을 1씩 증가 시킨다.
  int groupedNotificationCounter = 1;

  // 알림 발생 함수!!
  Future<void> _showGroupedNotifications() async {
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
    int num = (pushTitleList.length >= 3) ? 0 : 1;
    
    

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
    await flutterLocalNotificationsPlugin.show(
        groupedNotificationCounter,
        pushTitleList[num],
        '스마트 플러그 작동 상태 - ${pushTitleList[num]}',
        notificationPlatformSpecifics);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showGroupedNotifications,
              child: Text("showGroupedNotifications"),
            ),
          ],
        ),
      ),
    );
  }
}
