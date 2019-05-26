import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:test_app/app_store.dart';
import 'package:test_app/config/route.dart';
import 'package:test_app/data/model/env.dart';
import 'package:test_app/environment/env.dart';
import 'package:test_app/page/home/home.dart';

class App extends StatefulWidget {
  AppStore application;
  App({@required this.application}) : assert(application != null);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    super.initState();
    if (Env.environmentType == EnvType.DEVELOPMENT ||
        Env.environmentType == EnvType.STAGING ||
        Env.environmentType == EnvType.TESTING) {
      Stetho.initialize();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.application.onTerminate();
  }

  @override
  Widget build(BuildContext context) {
    return Routes(initialRoute: HomePage.PATH);
  }
}
