import 'package:logging/logging.dart';
import 'package:test_app/config/config.dart';
import 'package:test_app/data/db/db_migration_listener.dart';
import 'package:test_app/data/db/db_repo.dart';
import 'package:test_app/data/model/env.dart';
import 'package:test_app/utility/db/database_helper.dart';
import 'package:test_app/utility/framework/application.dart';
import 'package:test_app/utility/log/log.dart';

class AppStore implements Application {
  DatabaseHelper _db;
  DBRepository dbRepository;

  @override
  Future<void> onCreate() async {
    _initLog();
    await _initDB();
    _initDBRepository();
  }

  @override
  Future<void> onTerminate() async {
    await _db.close();
  }

  Future<void> _initDB() async {
    DBMigrationListener migrationListener =
        DBMigrationListener();
    DatabaseConfig databaseConfig = DatabaseConfig(
        Config.dbVersion, Config.dbName, migrationListener);
    _db = DatabaseHelper(databaseConfig: databaseConfig);
    await _db.open();
  }

  void _initDBRepository() {
    dbRepository = DBRepository(_db.database);
  }

  void _initLog() {
    Log.init();

    switch (Config.environmentType) {
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
