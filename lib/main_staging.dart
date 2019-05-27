import 'package:flutter/material.dart';
import 'package:test_app/app.dart';
import 'package:test_app/environment/env.dart';
import 'package:test_app/init.dart';
import 'package:test_app/widget/initial_loading_view.dart';

Future main() async {
  runApp(
    Init(
      configENV: () => Env.isStaging(),
      appBuilder: (BuildContext ctx, String init) => App(),
      splash: LoadingView(),
    )
  );
}