import 'package:flutter/material.dart';
import 'package:test_app/utility/styles.dart';

final ThemeData theme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryColor: colorPrimary,
    accentColor: colorPrimary,
    // primaryTextTheme: _buildPrimaryTextTheme(base.primaryTextTheme),
    // primaryColorBrightness: Brightness.light,
    // scaffoldBackgroundColor: bgColorBase,
    // canvasColor: bgColorCanvas,
    // buttonColor: colorPrimary,
    // disabledColor: bgColorDisabled,
    // dividerColor: dividerColor,
    // errorColor: colorError,
    // hintColor: fontColorLight,
    // appBarTheme: _buildAppBarTheme(base.appBarTheme),
    // buttonTheme: _buildButtonTheme(base.buttonTheme),
    // chipTheme: _buildChipTheme(base.chipTheme),
    // iconTheme: _buildIconThemeData(base.iconTheme),
  );
}

AppBarTheme _buildAppBarTheme(AppBarTheme base) => base.copyWith(
      elevation: headerBarElevation,
      color: headerBarColor,
      brightness: headerBarBrightness,
      iconTheme: headerBarIconTheme,
      textTheme: headerBarTextTheme,
    );

TextTheme _buildTextTheme(TextTheme base) => base
    .apply(
      fontFamily: fontFamilyPrimary,
      bodyColor: fontColorPrimary,
      displayColor: fontColorPrimary,
    )
    .copyWith(
      body1: base.body1.copyWith(
        fontSize: fontSizePrimary,
      ),
      button: base.button.copyWith(
        color: fontColorOnDark,
        fontSize: fontSizePrimary,
        fontWeight: FontWeight.bold,
      ),
    );

TextTheme _buildPrimaryTextTheme(TextTheme base) => base
    .copyWith(
      title: headerBarTitleStyle,
    )
    .apply(
      fontFamily: fontFamilyPrimary,
    );

ButtonThemeData _buildButtonTheme(ButtonThemeData base) => base.copyWith(
      shape: buttonShape,
      padding: buttonPadding,
      buttonColor: colorPrimary,
      disabledColor: buttonDisabledColor,
    );

ChipThemeData _buildChipTheme(ChipThemeData base) => base.copyWith(
      labelStyle: const TextStyle(
        color: fontColorOnDark,
      ),
      backgroundColor: colorPrimary,
    );

IconThemeData _buildIconThemeData(IconThemeData base) => base.copyWith(
      size: iconSizeLarge,
    );
