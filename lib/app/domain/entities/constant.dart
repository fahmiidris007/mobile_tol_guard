import 'dart:ui';

class Constant {
  static String appName = 'Mobile Tol Guard';

  /// Database
  static String dbName = 'mobile_tol_guard.db';
  static int dbVersion = 1;
  static String userTable = 'user';
  static String languageTable = 'language';

  /// Localization
  static Locale localeEn = const Locale('en', 'US');
  static Locale localeId = const Locale('id', 'ID');

  /// Master key
  static String masterKey = 'hidupjokowi';

  /// TYPE REST API
  static const String get = 'GET';
  static const String post = 'POST';

  /// API
  // Login
  /// TODO : add this path api if backend service is already
  static String login = '';
}
