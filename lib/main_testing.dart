import 'package:test_app/env.dart';

main() => Testing();

class Testing extends Env {
  final String appName = "Pokeapp_Staging";
  EnvType environmentType = EnvType.TESTING;
  final String baseUrl = 'https://raw.githubusercontent.com';
  
  final String dbName = 'pokemon_staging.db';
}