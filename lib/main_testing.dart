import 'package:flutter/material.dart';
import 'package:test_app/app_component.dart';
import 'package:test_app/config/config.dart';

void main() {
  Config.isTesting();
  runApp(AppComponent());
}