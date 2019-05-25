import 'package:flutter/material.dart';
import 'package:test_app/app_component.dart';
import 'package:test_app/config/config.dart';
import 'package:test_app/di/injector.dart';
import 'package:test_app/utility/framework/application.dart';

Future main() async {
  Config.isProduction();

  final InjectorContainer injector = InjectorContainer();
  injector.initDependencyInjection();

  Application application = injector.getAppStoreInstance();
  await application.onCreate();
  
  runApp(AppComponent(application: application,));
}