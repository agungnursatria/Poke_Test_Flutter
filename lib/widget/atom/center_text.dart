import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  final String text;

  CenterText({this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
          child: Text(
        text,
        textAlign: TextAlign.center,
      )),
    );
  }
}
