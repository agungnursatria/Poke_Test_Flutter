import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:test_app/app.dart';
import 'package:test_app/data/model/env.dart';
import 'package:test_app/di/injector.dart';
import 'package:test_app/environment/env.dart';
import 'package:test_app/page/home/home.dart';

void main() {
  Env.isTesting();

  if (Env.environmentType == EnvType.DEVELOPMENT ||
      Env.environmentType == EnvType.STAGING ||
      Env.environmentType == EnvType.TESTING) {
    Stetho.initialize();
  }

  final InjectorContainer injector = InjectorContainer();
  injector.initDependencyInjection();
  
  runApp(App(
    initialRoute: HomePage.PATH,
  ));
}