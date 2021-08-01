import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart' as mysql;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MangedInfoPage(),
    );
  }
}

class MangedInfoPage extends StatefulWidget {
  const MangedInfoPage({Key? key}) : super(key: key);

  @override
  _MangedInfoPageState createState() => _MangedInfoPageState();
}

class _MangedInfoPageState extends State<MangedInfoPage> {
  List<dynamic> managedInfo = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart'),
      ),
      body: ListView.builder(
        itemCount: managedInfo.length,
        itemBuilder: (context, index) => movieCard(index),
      ),
    );
  }

  Widget movieCard(int index) {
    var info = managedInfo[index];

    var machineName2 = managedInfo[index]['name'];

    var machineName = managedInfo[index]['name'].toString().replaceRange(
        managedInfo[index]['name'].toString().length,
        managedInfo[index]['name'].toString().length,
        '');
    var location = managedInfo[index]['location'].toString();

    var plugId = managedInfo[index]['plug_id'].toString().replaceRange(
        managedInfo[index]['plug_id'].toString().length,
        managedInfo[index]['plug_id'].toString().length,
        '');
    var storeId = managedInfo[index]['store_id'].toString().replaceRange(
        managedInfo[index]['store_id'].toString().length,
        managedInfo[index]['store_id'].toString().length,
        '');

    // var storeId;
    // if (!managedInfo[index]['release_date'].toString().contains('-')) {
    //   storeId = managedInfo[index]['release_date'].toString() + 'year';
    // } else {
    //   storeId =
    //       managedInfo[index]['release_date'].toString().replaceFirst('-', 'year');
    //   storeId = storeId.replaceFirst('-', 'month') + 'day';
    // }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      margin: EdgeInsets.only(top: 10, left: 8, right: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Color(0xffffffff),
                offset: Offset(0.0, 6.0),
                blurRadius: 0,
                spreadRadius: 0)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: 150,
                width: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print(info['id'].toString());
                      },
                      child: Text(info['id'].toString()),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'ID:',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: info['id']
                              .toString(), // 이렇게 info로 변수 선언 안하고 출력도 가능은 함
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Plug ID:',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: info['plug_id']
                              .toString(), // 이렇게 info로 변수 선언 안하고 출력도 가능은 함
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ]),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Store ID:',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: storeId,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ]),
                    ),
                    RichText(
                      softWrap: true,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Machine Name:',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: machineName2,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ]),
                    ),
                    RichText(
                      softWrap: true,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Location:',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: location,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ]),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future Database() async {
    var settings = new mysql.ConnectionSettings(
        host: '13.209.100.19', user: 'kym', password: 'kim', db: 'db');
    var conn = await mysql.MySqlConnection.connect(settings);
    var result = await conn.query("select * from Product");
    await conn.close();
    setState(() {
      managedInfo = result.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    Database();
  }
}
