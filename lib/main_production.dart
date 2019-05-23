import 'package:test_app/env.dart';

main() => Production();

class Production extends Env {
  final String appName = "Pokeapp";
  EnvType environmentType = EnvType.PRODUCTION;
  final String baseUrl = 'https://raw.githubusercontent.com';
  
  final String dbName = 'pokemon.db';
}