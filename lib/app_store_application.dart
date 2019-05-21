import 'package:logging/logging.dart';
import 'package:test_app/config/env.dart';
import 'package:test_app/di/injector.dart';
import 'package:test_app/utility/framework/application.dart';
import 'package:test_app/utility/log/log.dart';

class AppStoreApplication implements Application {
  // DatabaseHelper _db;
  // DBAppStoreRepository dbAppStoreRepository;
  // AppStoreAPIRepository appStoreAPIRepository;

  @override
  Future<void> onCreate() async {
    _initLog();
    _initInjection();
    // _initRouter();
    // await _initDB();
    // _initDBRepository();
    // _initAPIRepository();
  }

  @override
  Future<void> onTerminate() async {
    // await _db.close();
  }

//   Future<void> _initDB() async {
//     AppDatabaseMigrationListener migrationListener = AppDatabaseMigrationListener();
//     DatabaseConfig databaseConfig = DatabaseConfig(Env.value.dbVersion, Env.value.dbName, migrationListener);
//     _db = DatabaseHelper(databaseConfig);
//     Log.info('DB name : ' + Env.value.dbName);
// //    await _db.deleteDB();
//     await _db.open();
//   }

//   void _initDBRepository(){

//     dbAppStoreRepository = DBAppStoreRepository(_db.database);
//   }

//   void _initAPIRepository(){
//     APIProvider apiProvider = APIProvider();
//     appStoreAPIRepository = AppStoreAPIRepository(apiProvider, dbAppStoreRepository);
//   }

  void _initInjection(){
    final InjectorContainer injector = InjectorContainer();
    injector.initDependencyInjection();
  }

  void _initLog(){
    Log.init();

    switch(Env.value.environmentType){
      case EnvType.TESTING:
      case EnvType.DEVELOPMENT:
      case EnvType.STAGING:{
        Log.setLevel(Level.ALL);
        break;
      }
      case EnvType.PRODUCTION:{
        Log.setLevel(Level.INFO);
        break;
      }
    }
  }
}