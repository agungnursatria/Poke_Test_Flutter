import 'package:test_app/app.dart';
import 'package:test_app/environment/env.dart';

Future main() async {
  Env.isTesting();
  App.run();
}