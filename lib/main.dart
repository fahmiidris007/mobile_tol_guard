import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mobile_tol_guard/app/domain/entities/constant.dart';
import 'package:mobile_tol_guard/app/domain/entities/global.dart';
import 'package:mobile_tol_guard/app/presentation/pages/splash/splash_screen_page.dart';
import 'package:mobile_tol_guard/core/services/injection.dart';
import 'package:mobile_tol_guard/core/translator/l10n.dart';
import 'package:mobile_tol_guard/core/translator/translator.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

void main() {
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Constant.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      locale: Get.deviceLocale,
      fallbackLocale: Constant.localeEn,
      localizationsDelegates: localizationsDelegates(),
      supportedLocales: const AppLocalizationDelegate().supportedLocales,
      navigatorKey: getIt<Global>().navigatorKey,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [NavigationHistoryObserver()],
      routes: {
        '/': (context) => const SplashScreenPage(),
      },
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) {
                return child ?? const Scaffold();
              },
            ),
          ],
        );
      },
    );
  }
}
