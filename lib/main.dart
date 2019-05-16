import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/dependency_injection/injector.dart';
import 'package:test_app/screens/detail/detail.dart';
import 'package:test_app/screens/home/bloc/home_bloc.dart';
import 'package:test_app/screens/home/home.dart';

main(){
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    final InjectorContainer injector = InjectorContainer();
    injector.initDependencyInjection();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _homeBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokemon App',
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (_) => HomePage(),
          '/detail': (_) => PokeDetailPage(),
        },
      ),
    );
  }

  @override
  void dispose() { 
    _homeBloc.dispose();
    super.dispose();
  }
}