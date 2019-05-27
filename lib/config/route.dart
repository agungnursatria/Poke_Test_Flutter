import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_app/config/theme.dart';
import 'package:test_app/environment/env.dart';
import 'package:test_app/page/detail/detail.dart';
import 'package:test_app/page/home/home.dart';
import 'package:test_app/config/localization/i18n.dart';
import 'package:test_app/page/landing/landing.dart';

class Routes extends StatelessWidget {
  String initialRoute;
  Routes({@required initialRoute}) : assert(initialRoute != null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: (Env.alice != null) ? Env.alice.getNavigatorKey() : null,
      theme: theme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: Env.appName,
      initialRoute: initialRoute,
      routes: <String, WidgetBuilder>{
        Landing.PATH: (_) => Landing(),
        HomePage.PATH: (_) => HomePage(),
        PokeDetailPage.PATH: (_) => PokeDetailPage(),
      },
    );
  }
}