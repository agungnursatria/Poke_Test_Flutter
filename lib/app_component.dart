import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:test_app/app_store.dart';
import 'package:test_app/config/config.dart';
import 'package:test_app/data/model/env.dart';
import 'package:test_app/di/injector.dart';
import 'package:test_app/page/home/home.dart';
import 'package:test_app/route.dart';

class AppComponent extends StatefulWidget {
  @override
  _AppComponentState createState() => _AppComponentState();
}

class _AppComponentState extends State<AppComponent> {
  AppStore application;

  @override
  void initState() {
    super.initState();
    if (Config.environmentType == EnvType.DEVELOPMENT ||
        Config.environmentType == EnvType.STAGING ||
        Config.environmentType == EnvType.TESTING) {
      Stetho.initialize();
    }

    final InjectorContainer injector = InjectorContainer();
    injector.initDependencyInjection();

    application = injector.getAppStoreInstance();
    application.onCreate();
  }

  @override
  void dispose() {
    super.dispose();
    application.onTerminate();
  }

  @override
  Widget build(BuildContext context) {
    return Routes(initialRoute: HomePage.PATH);
  }
}
