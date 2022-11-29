import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:untitled2/screens/home.dart';

void main() {
  runApp(show_home());
}

class show_home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
       Scaffold(
        appBar: AppBar(
          title: Text('AppListProduct'),
        ),
        body: home(),
        
      ),
    );
  }
}
