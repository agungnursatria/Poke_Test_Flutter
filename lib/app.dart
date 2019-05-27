import 'package:flutter/material.dart';
import 'package:test_app/config/route.dart';
import 'package:test_app/page/landing/landing.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {  
  @override
  Widget build(BuildContext context) {
    return Routes(initialRoute: Landing.PATH);
  }
}
