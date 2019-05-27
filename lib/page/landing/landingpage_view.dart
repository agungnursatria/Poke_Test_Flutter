import 'package:flutter/material.dart';

class LandingPageView extends StatelessWidget {
  const LandingPageView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 60,
          width: 60,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}