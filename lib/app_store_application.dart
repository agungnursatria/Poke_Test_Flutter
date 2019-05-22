import 'package:logging/logging.dart';
import 'package:test_app/data/db/app_database_migration_listener.dart';
import 'package:test_app/data/db/db_appstore_repository.dart';
import 'package:test_app/env.dart';
import 'package:test_app/utility/db/database_helper.dart';
import 'package:test_app/utility/framework/application.dart';
import 'package:test_app/utility/log/log.dart';

class AppStore implements Application {
  DatabaseHelper _db;
  DBAppStoreRepository dbAppStoreRepository;
  // AppStoreAPIRepository appStoreAPIRepository;

  @override
  Future<void> onCreate() async {
    _initLog();
    await _initDB();
    _initDBRepository();
    // _initAPIRepository();
  }

  @override
  Future<void> onTerminate() async {
    await _db.close();
  }

  Future<void> _initDB() async {
    AppDatabaseMigrationListener migrationListener =
        AppDatabaseMigrationListener();
    DatabaseConfig databaseConfig = DatabaseConfig(
        Env.value.dbVersion, Env.value.dbName, migrationListener);
    _db = DatabaseHelper(databaseConfig: databaseConfig);
    Log.info('DB name : ' + Env.value.dbName);
//    await _db.deleteDB();
    await _db.open();
  }

  void _initDBRepository() {
    dbAppStoreRepository = DBAppStoreRepository(_db.database);
  }

//   void _initAPIRepository(){
//     APIProvider apiProvider = APIProvider();
//     appStoreAPIRepository = AppStoreAPIRepository(apiProvider, dbAppStoreRepository);
//   }

  void _initLog() {
    Log.init();

    switch (Env.value.environmentType) {
      case EnvType.TESTING:
      case EnvType.DEVELOPMENT:
      case EnvType.STAGING:
        {
          Log.setLevel(Level.ALL);
          break;
        }
      case EnvType.PRODUCTION:
        {
          Log.setLevel(Level.INFO);
          break;
        }
    }
  }
}
