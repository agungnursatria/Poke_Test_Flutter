import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:test_app/di/injector.dart';
import 'package:test_app/environment/env.dart';
import 'package:test_app/utility/framework/application.dart';

class Init extends StatelessWidget {
  final Function() configENV;
  final Widget Function(BuildContext context, String initPath) appBuilder;
  final Widget splash;

  Init({
    @required this.configENV,
    @required this.appBuilder,
    @required this.splash,
  });

  Future init() async {
    configENV();

    if (Env.isDebug()) {
      Stetho.initialize();
      Env.alice = Alice(showNotification: true);
    }

    final InjectorContainer injector = InjectorContainer();
    injector.initDependencyInjection();

    Application application = injector.getAppStoreInstance();
    await application.onCreate();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          return appBuilder(context, '/');
        }
        return splash;
      },
    );
  }
}
