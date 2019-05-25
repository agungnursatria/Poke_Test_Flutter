import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_app/config/config.dart';
import 'package:test_app/page/detail/detail.dart';
import 'package:test_app/page/home/home.dart';
import 'package:test_app/utility/localization/i18n.dart';
import 'package:test_app/utility/theme.dart';

class Routes extends StatelessWidget {
  String initialRoute;
  Routes({@required initialRoute}) : assert(initialRoute != null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: (Config.alice != null) ? Config.alice.getNavigatorKey() : null,
      theme: theme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: Config.appName,
      initialRoute: initialRoute,
      routes: <String, WidgetBuilder>{
        HomePage.PATH: (_) => HomePage(),
        PokeDetailPage.PATH: (_) => PokeDetailPage(),
      },
    );
  }
}