import 'package:flutter/material.dart';

class DeveloperInfo extends StatelessWidget {
  const DeveloperInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeveloperInfo'),
      ),
      body: const Center(
        child: Text('DeveloperInfo',
          style: TextStyle(
              fontSize: 24.0
          ),
        ),
      ),
    );
  }
}