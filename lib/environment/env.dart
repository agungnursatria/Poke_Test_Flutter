
enum EnvType { DEVELOPMENT, STAGING, PRODUCTION, TESTING }

class Env{
  static String appName;
  static EnvType environmentType;

  static String dbName;
  static int dbVersion;

  static String baseUrl;

  static void isDevelopment() {
    appName = "Pokeapp-Dev";
    environmentType = EnvType.DEVELOPMENT;
    dbName = 'pokemon_dev.db';
    dbVersion = 1;
    baseUrl = 'https://raw.githubusercontent.com';
  }

  static void isProduction() {
    appName = 'Pokeapp';
    environmentType = EnvType.PRODUCTION;
    dbName = 'pokemon.db';
    dbVersion = 1;
    baseUrl = 'https://raw.githubusercontent.com';
  }

  static void isStaging() {
    appName = 'Pokemon-Staging';
    environmentType = EnvType.STAGING;
    dbName = 'pokemon_staging.db';
    dbVersion = 1;
    baseUrl = 'https://raw.githubusercontent.com';
  }

  static void isTesting() {
    appName = 'Pokemon-Testing';
    environmentType = EnvType.TESTING;
    dbName = 'pokemon_testing.db';
    dbVersion = 1;
    baseUrl = 'https://raw.githubusercontent.com';
  }

  static bool isDebug() => environmentType != EnvType.PRODUCTION;

}