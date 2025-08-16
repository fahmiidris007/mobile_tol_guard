import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapItemData {
  int id;
  String? name;
  LatLng latLng;
  String imageUrl;
  String? description;
  bool pinned;
  MapItemData({
    required this.id,
    this.name,
    required this.latLng,
    required this.imageUrl,
    this.description,
    this.pinned = false,
  });
}
