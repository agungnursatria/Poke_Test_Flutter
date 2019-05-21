import 'package:test_app/env.dart';

main() => MainApp();

class MainApp extends Env {
  final String appName = "Pokeapp";
  EnvType environmentType = EnvType.DEVELOPMENT;
  final String dbName = 'pokemon.db';
}