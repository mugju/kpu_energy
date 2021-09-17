import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: FirstRoute()));
}

class FirstRoute extends StatefulWidget {
  @override
  State createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  String text = 'first';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text('Open route ' + text),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int counter = (prefs.getInt('counter') ?? 0) + 1;
                await prefs.setInt('counter', counter);

                setState(() {
                  text = 'Pressed $counter times.';
                });
              },
            ),
            TextButton(
              onPressed: () async {
                print('text button');
                SharedPreferences prefs2 = await SharedPreferences.getInstance();
                int cnt = (prefs2.getInt('cnt') ?? 0) + 1;
                await prefs2.setInt('cnt', cnt);
                setState(() {
                  text = 'Pressed $cnt times.';
                });
              },
              
              child: Text(
                '테스트 시작',
                style: TextStyle(
                  fontSize: 20.0,
                  //color: Colors.red,
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.orange,
                //backgroundColor: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
