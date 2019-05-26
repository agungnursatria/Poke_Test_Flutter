import 'package:flutter/material.dart';
import 'package:test_app/app_component.dart';
import 'package:test_app/environment/env.dart';
import 'package:test_app/di/injector.dart';
import 'package:test_app/utility/framework/application.dart';

Future main() async {
  Env.isStaging();

  final InjectorContainer injector = InjectorContainer();
  injector.initDependencyInjection();

  Application application = injector.getAppStoreInstance();
  await application.onCreate();
  
  runApp(AppComponent(application: application,));
}