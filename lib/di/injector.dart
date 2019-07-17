import 'package:alice/alice.dart';
import 'package:kiwi/kiwi.dart';
import 'package:test_app/app_store.dart';
import 'package:test_app/data/network/network_interface.dart';
import 'package:test_app/data/network/network_library.dart';
import 'package:test_app/environment/env.dart';
import 'package:test_app/page/home/service/home_service.dart';

class InjectorContainer {
  InjectorContainer();

  void initDependencyInjection() {
    final Container container = Container();
    container.registerInstance(NetworkLibrary());
    container.registerInstance(AppStore());
    container.registerInstance(Alice(showNotification: Env.isDebug()));
    container
        .registerFactory((c) => NetworkInterface(c.resolve<NetworkLibrary>()));
    container.registerFactory((c) => HomeService(
        c.resolve<NetworkInterface>(), c.resolve<AppStore>().dbRepository));
  }

  Alice getAliceInstance() {
    final Container container = Container();
    return container.resolve<Alice>();
  }

  HomeService getHomeServiceInstance() {
    final Container container = Container();
    return container.resolve<HomeService>();
  }

  AppStore getAppStoreInstance() {
    final Container container = Container();
    return container.resolve<AppStore>();
  }
}
