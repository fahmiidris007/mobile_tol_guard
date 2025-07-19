import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_tol_guard/app/domain/entities/constant.dart';
import 'package:mobile_tol_guard/app/domain/entities/global.dart';
import 'package:mobile_tol_guard/core/services/injection.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_tol_guard/core/util/preferences.dart';

import 'l10n.dart';

final BuildContext? _context =
    getIt<Global>().navigatorKey.currentState?.context;

S get translator {
  final instance = S.maybeOf(_context!);
  assert(instance != null,
      'No instance of Translator present in the widget tree. Did you add Translator.delegate in localizationsDelegates?');
  return instance!;
}

Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates() {
  return [
    const AppLocalizationDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate
  ];
}

loadLang() async {
  var lang = await Prefs.getLanguage;
  switch (lang) {
    case 'en':
      Get.updateLocale(Constant.localeEn);
      break;
    case 'id':
      Get.updateLocale(Constant.localeId);
      break;
  }
}
