import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_tol_guard/app/domain/entities/bottom_navbar_data.dart';
import 'package:mobile_tol_guard/app/presentation/pages/home/dashboard_page.dart';
import 'package:mobile_tol_guard/app/presentation/pages/maps/maps_page.dart';
import 'package:mobile_tol_guard/app/presentation/pages/settings/settings_page.dart';
import 'package:mobile_tol_guard/core/translator/translator.dart';
import 'package:mobile_tol_guard/core/util/assets.dart';

import '../../app/domain/entities/map_item_data.dart';

class StaticData {
  static Future<List<BottomNavbarData>> get listNavbar async => [
        BottomNavbarData(
          icon: Assets.imagesIcHome,
          title: translator.home,
          page: const DashboardPage(),
        ),
        BottomNavbarData(
          icon: Assets.imagesIcMaps,
          title: 'Maps',
          page: const MapsPage(),
        ),
        BottomNavbarData(
          icon: Assets.imagesIcSettings,
          title: translator.settings,
          page: const SettingsPage(),
        ),
      ];

  static List<MapItemData> streetEvent = [
    MapItemData(
      id: 1,
      name: 'Jln. KM 56',
      latLng: LatLng(-6.204125, 106.461158),
      imageUrl: Assets.imagesEvent1,
      pinned: false,
    ),
    MapItemData(
      id: 2,
      name: 'Jln. KM 7',
      latLng: LatLng(-6.200202, 106.448843),
      imageUrl: Assets.imagesEvent2,
      pinned: false,
    ),
    MapItemData(
      id: 3,
      name: 'Jln. KM 10',
      latLng: LatLng(-6.201430, 106.455136),
      imageUrl: Assets.imagesEvent3,
      pinned: false,
    ),
    MapItemData(
      id: 4,
      name: 'Jln. KM 18',
      latLng: LatLng(-6.205526, 106.464611),
      imageUrl: Assets.imagesEvent4,
      pinned: false,
    ),
    MapItemData(
      id: 5,
      name: 'Jln. KM 50',
      latLng: LatLng(-6.205710, 106.466041),
      imageUrl: Assets.imagesEvent5,
      pinned: false,
    ),
  ];
}
