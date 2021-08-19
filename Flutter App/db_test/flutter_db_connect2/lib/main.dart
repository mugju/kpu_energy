import 'package:flutter/material.dart';
import 'package:flutter_db_connect2/model/mysql.dart';

import 'model/product.dart';

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
  List<Product> productList = [];

  void _getCustomer() {
    db.getConnection().then((conn) {
      String sql = 'select id, name, location from Product';
      conn.query(sql).then((results) {
        for (var column in results) {
          setState(() {
            Product product = new Product(column[0], column[1], column[2]);
            productList.add(product);
          });
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
        child: Column(
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'db: ',
            ),
            if (productList.length != 0)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var product in productList)
                    Text(
                      '${product.id} ${product.name} ${product.location}',
                    ),
                ],
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
