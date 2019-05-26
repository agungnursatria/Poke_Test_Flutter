import 'package:flutter/material.dart';
import 'package:test_app/app.dart';
import 'package:test_app/di/injector.dart';
import 'package:test_app/environment/env.dart';
import 'package:test_app/utility/framework/application.dart';

Future main() async {
  Env.isDevelopment();

  final InjectorContainer injector = InjectorContainer();
  injector.initDependencyInjection();

  Application application = injector.getAppStoreInstance();
  await application.onCreate();
  
  runApp(App(application: application,));
}