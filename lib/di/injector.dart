import 'package:kiwi/kiwi.dart';
import 'package:test_app/app_store_application.dart';
import 'package:test_app/data/db/db_appstore_repository.dart';
import 'package:test_app/data/network/network_interface.dart';
import 'package:test_app/page/home/service/home_service.dart';

class InjectorContainer {
  InjectorContainer();

  void initDependencyInjection(){
    final Container container = Container();
    container.registerInstance(NetworkInterface());
    container.registerInstance(AppStore());
    container.registerFactory((c) => c.resolve<AppStore>().dbAppStoreRepository);
    container.registerFactory((c) => HomeService(c.resolve<NetworkInterface>(), c.resolve<DBAppStoreRepository>()));
  }

  HomeService getHomeServiceInstance(){
    final Container container = Container();
    return container.resolve<HomeService>();
  }

  AppStore getAppStoreInstance(){
    final Container container = Container();
    return container.resolve<AppStore>();
  }

}