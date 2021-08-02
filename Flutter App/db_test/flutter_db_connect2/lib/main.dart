import 'package:flutter/material.dart';
import 'package:flutter_db_connect2/model/mysql.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var db = Mysql();
  var id = <int>[];
  var name = <String>[];
  var location = <String>[];

  void _getCustomer() {
    db.getConnection().then((conn) {
      String sql = 'select id, name, location from Product';
      conn.query(sql).then((results) {
        for (var column in results) {
          for (var row in results) {
            setState(() {
              id[column.indexOf(results)] = row[0];
              name[column.indexOf(results)] = row[1];
              location[column.indexOf(results)] = row[2];
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'db: ',
            ),
            Text(
              '$id' + ', ',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$name' + ', ',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$location',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCustomer,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
