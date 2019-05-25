import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

//This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class S implements WidgetsLocalizations {
  const S();

  static const GeneratedLocalizationsDelegate delegate =
    GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get height => "Height: ";
  String get weight => "Weight: ";
  String get types => "Types";
  String get weakness => "Weakness";
  String get nextevolution => "Next Evolution";
  String get no => "No";
  String get yes => "Yes";
  String get closeDialog => "Do you want to exit the App";
  String get closeDialogTitle => "Are you sure?";
  String get emptypokemon => "No Pokemon Here";
  String get retringIn5Second => "Retrying in 5 seconds";
}

class $id extends S {
  const $id();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get height => "Tinggi: ";
  @override
  String get weight => "Berat: ";
  @override
  String get types => "Tipe";
  @override
  String get weakness => "Kelemahan";
  @override
  String get nextevolution => "Evolusi Selanjutnya";
  @override
  String get no => "Tidak";
  @override
  String get yes => "Ya";
  @override
  String get closeDialog => "Apakah anda ingin menutup aplikasi ini?";
  @override
  String get closeDialogTitle => "Anda yakin?";
  @override
  String get emptypokemon => "Tidak ada pokemon disini";
  @override
  String get retringIn5Second => "Mencoba kembali dalam 5 detik";
}

class $en extends S {
  const $en();
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", ""),
      Locale("id", ""),
    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported);
    };
  }

  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported) {
    if (locale == null || !isSupported(locale)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "en":
          return SynchronousFuture<S>(const $en());
        case "id":
          return SynchronousFuture<S>(const $id());
        default:
          // NO-OP.
      }
    }
    return SynchronousFuture<S>(const S());
  }

  @override
  bool isSupported(Locale locale) =>
    locale != null && supportedLocales.contains(locale);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}

String getLang(Locale l) => l == null
  ? null
  : l.countryCode != null && l.countryCode.isEmpty
    ? l.languageCode
    : l.toString();
