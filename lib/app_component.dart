import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app_store_application.dart';
import 'package:test_app/env.dart';
import 'package:test_app/page/detail/detail.dart';
import 'package:test_app/page/home/bloc/home_bloc.dart';
import 'package:test_app/page/home/home.dart';
import 'package:test_app/utility/log/log.dart';

class AppComponent extends StatefulWidget {

  final AppStoreApplication _application;

  AppComponent(this._application);
  
  @override
  _AppComponentState createState() => _AppComponentState();
}

class _AppComponentState extends State<AppComponent> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void dispose()async{
    Log.info('dispose');
    await widget._application.onTerminate();

    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _homeBloc,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.black,
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          ),
          primaryIconTheme:
              Theme.of(context).primaryIconTheme.copyWith(color: Colors.white),
        ),
        debugShowCheckedModeBanner: false,
        title: Env.value.appName,
        initialRoute: HomePage.PATH,
        routes: <String, WidgetBuilder>{
          HomePage.PATH : (_) => HomePage(),
          PokeDetailPage.PATH : (_) => PokeDetailPage(),
        },
      ),
    );
  }
}
