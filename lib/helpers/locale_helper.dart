import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../core/core.dart';
import 'shared_pref_helper.dart';

class LocaleHelper {
  LocaleHelper._();

  static LocaleHelper get instance => LocaleHelper._();
  static Locale locale = const Locale(LocaleConstants.japanese);

  bool isEnglish() {
    final currentLocale = locale.toString();
    return currentLocale == LocaleConstants.english ||
        currentLocale == LocaleConstants.enUS;
  }

  List<Locale> get supportedLocales =>
      const [Locale(LocaleConstants.japanese), Locale(LocaleConstants.english)];

  Locale get fallbackLocale => const Locale(LocaleConstants.japanese);

  Future<Locale> getDefaultLocale() async {
    final cachedLocale = await SharePrefHelper.instance.getLocale;
    final _locale = Locale(cachedLocale ?? LocaleConstants.japanese);
    locale = _locale;
    return _locale;
  }

  Future<void> setDefaultLocale(BuildContext context,
      {required String localeString}) async {
    final _ = await SharePrefHelper.instance.setLocale(localeString);
    final _locale = Locale(localeString);
    locale = _locale;
    await context.setLocale(_locale);
  }
}
