import 'package:test_app/env.dart';

main() => Staging();

class Staging extends Env {
  final String appName = "Pokeapp_Staging";
  EnvType environmentType = EnvType.STAGING;
  final String baseUrl = 'https://raw.githubusercontent.com';
  
  final String dbName = 'pokemon_staging.db';
}