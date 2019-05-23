import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/app_store.dart';
import 'package:test_app/env.dart';
import 'package:test_app/utility/language/i18n.dart';
import 'package:test_app/page/detail/detail.dart';
import 'package:test_app/page/home/bloc/home_bloc.dart';
import 'package:test_app/page/home/home.dart';
import 'package:test_app/utility/log/log.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_app/utility/theme.dart';

class AppComponent extends StatefulWidget {
  final AppStore _application;

  AppComponent(this._application);

  @override
  _AppComponentState createState() => _AppComponentState();
}

class _AppComponentState extends State<AppComponent> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void dispose() async {
    Log.info('dispose');
    await widget._application.onTerminate();

    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<HomeBloc>(
          bloc: _homeBloc,
        ),
      ],
      child: MaterialApp(
        navigatorKey: (Env.value.alice != null)
            ? Env.value.alice.getNavigatorKey()
            : null,
        theme: theme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: Env.value.appName,
        initialRoute: HomePage.PATH,
        routes: <String, WidgetBuilder>{
          HomePage.PATH: (_) => HomePage(),
          PokeDetailPage.PATH: (_) => PokeDetailPage(),
        },
      ),
    );
  }
}
