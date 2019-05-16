import 'package:kiwi/kiwi.dart';
import 'package:test_app/network/network_interface.dart';
import 'package:test_app/screens/home/service/home_service.dart';

class InjectorContainer {
  InjectorContainer();

  void initDependencyInjection(){
    final Container container = Container();
    container.registerInstance(NetworkInterface());
    container.registerFactory((c) => HomeService(c.resolve<NetworkInterface>()));
  }

  HomeService getHomeServiceInstance(){
    final Container container = Container();
    return container.resolve<HomeService>();
  }

}