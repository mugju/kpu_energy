import 'package:flutter/material.dart';
import 'package:flutter_db_connect3/model/mysql.dart';

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
  List<ProductAmp> productAmpList = [];
  List<ProductStore> productStoreList = [];

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

  void _getAmp() {
    db.getConnection().then((conn) {
      String sql =
          'SELECT name, round(amp, 2) FROM Product Inner Join (SELECT id, sum(amp) amp FROM Smart_plug group by id) sum_amp on Product.id = sum_amp.id';
      conn.query(sql).then((results) {
        for (var column in results) {
          setState(() {
            ProductAmp productAmp = new ProductAmp(column[0], column[1]);
            productAmpList.add(productAmp);
          });
        }
      });
    });
  }

  void _getStore() {
    db.getConnection().then((conn) {
      String sql =
          'SELECT * from Store';
      conn.query(sql).then((results) {
        for (var column in results) {
          setState(() {
            ProductStore productStore = new ProductStore(column[0], column[1], column[2], column[3]);
            productStoreList.add(productStore);
          });
        }
      });
    });
  }


  @override
  initState() {
    super.initState();
    _getAmp();
    _getStore();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // horizontal
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
            Text(
              'Amp: ',
            ),
            if (productAmpList.length != 0)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var productAmp in productAmpList)
                    Text(
                      '${productAmp.name} ${productAmp.amp}',
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
