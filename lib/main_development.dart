import 'package:test_app/env.dart';

main() => Development();

class Development extends Env {
  final String appName = "Pokeapp-Dev";
  EnvType environmentType = EnvType.DEVELOPMENT;
  final String baseUrl = 'https://raw.githubusercontent.com';
  
  final String dbName = 'pokemon_dev.db';
}