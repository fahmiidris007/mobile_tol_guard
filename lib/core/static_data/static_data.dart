import 'package:mobile_tol_guard/app/domain/entities/bottom_navbar_data.dart';
import 'package:mobile_tol_guard/app/presentation/pages/home/dashboard_page.dart';
import 'package:mobile_tol_guard/app/presentation/pages/settings/settings_page.dart';
import 'package:mobile_tol_guard/core/translator/translator.dart';
import 'package:mobile_tol_guard/core/util/assets.dart';

class StaticData {
  static Future<List<BottomNavbarData>> get listNavbar async => [
        BottomNavbarData(
          icon: Assets.imagesIcHome,
          title: translator.home,
          page: const DashboardPage(),
        ),
        BottomNavbarData(
          icon: Assets.imagesIcSettings,
          title: translator.settings,
          page: const SettingsPage(),
        ),
      ];
}
