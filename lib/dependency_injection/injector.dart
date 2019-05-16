import 'package:kiwi/kiwi.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/network_interface.dart';
import 'package:test_app/bloc/home_service.dart';

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