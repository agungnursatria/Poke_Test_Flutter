import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:test_app/app_component.dart';
import 'package:test_app/di/injector.dart';
import 'package:alice/alice.dart';

enum EnvType { DEVELOPMENT, STAGING, PRODUCTION, TESTING }

class Env {
  static Env value;

  String appName;
  EnvType environmentType = EnvType.DEVELOPMENT;
  Alice alice;

  // Database Config
  int dbVersion = 1;
  String dbName;

  Env() {
    value = this;
    _init();
  }

  void _init() async {
    if (EnvType.DEVELOPMENT == environmentType ||
        EnvType.STAGING == environmentType ||
        EnvType.TESTING == environmentType) {
      Stetho.initialize();
      alice = Alice(showNotification: true);
    }

    final InjectorContainer injector = InjectorContainer();
    injector.initDependencyInjection();

    var application = injector.getAppStoreInstance();
    await application.onCreate();
    runApp(AppComponent(application));
  }
}
