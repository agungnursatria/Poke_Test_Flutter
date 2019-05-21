import 'package:test_app/config/env.dart';

main() => Development();

class Development extends Env {
  final String appName = "Pokeapp";
  EnvType environmentType = EnvType.DEVELOPMENT;
  final String dbName = 'pokemon.db';
}