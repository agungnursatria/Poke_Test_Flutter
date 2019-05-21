import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:test_app/app_component.dart';
import 'package:test_app/di/injector.dart';

enum EnvType { DEVELOPMENT, STAGING, PRODUCTION, TESTING }

class Env {
  static Env value;

  String appName;
  EnvType environmentType = EnvType.DEVELOPMENT;

  // Database Config
  int dbVersion = 1;
  String dbName;

  Env() {
    value = this;
    _init();
  }

  void _init() async {
    if (EnvType.DEVELOPMENT == environmentType ||
        EnvType.STAGING == environmentType) {
      Stetho.initialize();
    }
    
    final InjectorContainer injector = InjectorContainer();
    injector.initDependencyInjection();

    var application = injector.getAppStoreApplicationInstance();
    await application.onCreate();
    runApp(AppComponent(application));
  }
}
