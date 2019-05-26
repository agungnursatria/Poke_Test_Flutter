import 'package:test_app/app.dart';
import 'package:test_app/environment/env.dart';

void main() {
  Env.isTesting();
  App.run();
}