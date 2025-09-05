import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobile_tol_guard/app/domain/entities/map_item_data.dart';
import 'package:mobile_tol_guard/core/static_data/static_data.dart';
import 'package:mobile_tol_guard/core/util/navigation.dart';
import 'package:mobile_tol_guard/core/util/utility.dart';

class MapsPage extends StatefulWidget {
  final MapItemData? firstPlace;
  const MapsPage({super.key, this.firstPlace});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late MapItemData pinnedPlace;
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  final Set<Marker> tempMarkers = {};
  MapType selectedMapType = MapType.normal;
  geo.Placemark? placemark;
  List<MapItemData> streetEvent = [];
  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }

  @override
  void initState() {
    super.initState();
    // temp data, change if backend api is ready
    pinnedPlace = widget.firstPlace ??
        MapItemData(
            id: 9, latLng: LatLng(-6.2000145, 106.4487782), imageUrl: '');
    streetEvent = StaticData.streetEvent;
    setMarkers();
    // temporary if add steerEvent from add place page
    if (widget.firstPlace?.imageUrl != null &&
        widget.firstPlace!.imageUrl.isNotEmpty) {
      streetEvent.insert(0, widget.firstPlace!);
    }
  }

  setMarkers() {
    final marker1 = Marker(
      markerId: const MarkerId('PAC'),
      position: pinnedPlace.latLng,
      onTap: () {
        mapController
            .animateCamera(CameraUpdate.newLatLngZoom(pinnedPlace.latLng, 15));
      },
    );
    markers.add(marker1);
    // add many markers
    for (var event in streetEvent) {
      markers.add(Marker(
          markerId: MarkerId('Event $event'),
          position: event.latLng,
          onTap: () {
            mapController
                .animateCamera(CameraUpdate.newLatLngZoom(event.latLng, 15));
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        navigatePop(true);
        return Future.value(true);
      },
      child: Center(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: pinnedPlace.latLng,
                zoom: 15,
              ),
              onMapCreated: (controller) async {
                final info = await geo.placemarkFromCoordinates(
                    pinnedPlace.latLng.latitude, pinnedPlace.latLng.longitude);
                final place = info[0];
                final street = place.street!;
                final address =
                    '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                setState(() {
                  placemark = place;
                });
                defineMarker(
                    latLng: pinnedPlace.latLng,
                    street: street,
                    address: address);
                setState(() {
                  mapController = controller;
                });
                final bound = boundsFromLatLngList(
                    [pinnedPlace.latLng, ...streetEvent.map((e) => e.latLng)]);
                mapController
                    .animateCamera(CameraUpdate.newLatLngBounds(bound, 50));
              },
              markers: {...markers, ...tempMarkers},
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              mapType: selectedMapType,
              myLocationEnabled: true,
              onTap: (LatLng latLng) {
                onTapMaps(latLng);
              },
            ),
            Positioned(
                bottom: 150,
                right: 20,
                child: Column(
                  children: [
                    FloatingActionButton.small(
                      heroTag: 'mapsPageMyLocationButton',
                      onPressed: () {
                        onMyLocationButtonPressed();
                      },
                      child: Icon(Icons.my_location),
                    ),
                    // FloatingActionButton.small(
                    //   onPressed: () {
                    //     mapController.animateCamera(CameraUpdate.zoomIn());
                    //   },
                    //   heroTag: 'zoom-in',
                    //   child: const Icon(Icons.add),
                    // ),
                    // FloatingActionButton.small(
                    //   onPressed: () {
                    //     mapController.animateCamera(CameraUpdate.zoomOut());
                    //   },
                    //   heroTag: 'zoom-out',
                    //   child: const Icon(Icons.remove),
                    // )
                  ],
                )),
            Positioned(
                top: 20,
                right: 20,
                child: FloatingActionButton.small(
                  heroTag: 'mapsPageLayersButton',
                  onPressed: () {},
                  child: PopupMenuButton(
                    icon: Icon(Icons.layers_outlined),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                          value: MapType.normal, child: Text('Normal')),
                      PopupMenuItem(
                          value: MapType.terrain, child: Text('Terrain')),
                      PopupMenuItem(
                          value: MapType.satellite, child: Text('Satellite')),
                      PopupMenuItem(
                          value: MapType.hybrid, child: Text('Hybrid')),
                    ],
                    onSelected: (MapType mapType) {
                      setState(() {
                        selectedMapType = mapType;
                      });
                    },
                  ),
                )),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    spacing: 12,
                    children: streetEvent.map((e) {
                      e.pinned = e.id == pinnedPlace.id;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            pinnedPlace = e;
                            e.pinned = true;
                            mapController.animateCamera(
                                CameraUpdate.newLatLngZoom(e.latLng, 15));
                          });
                        },
                        child: Container(
                          width: e.pinned ? 150 : 100,
                          height: e.pinned ? 100 : 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: e.pinned
                                ? Border.all(
                                    color: Colors.blue,
                                    width: 1,
                                  )
                                : null,
                          ),
                          child: ClipRRect(
                            // Use ClipRRect to apply borderRadius to the Image widget
                            borderRadius: BorderRadius.circular(10.0),
                            child: Utility.buildImage(
                                e.imageUrl), // Use a helper method
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onMyLocationButtonPressed() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("Location services is not available");
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("Location permission is denied");
        return;
      }
    }
    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];
    final street = place.street;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      placemark = place;
    });
    defineMarker(
        latLng: latLng, id: 'My Location', street: street, address: address);
    mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
  }

  void defineMarker(
      {required LatLng latLng,
      String? id,
      String? street,
      String? address,
      bool isTemp = false}) {
    final marker = Marker(
        markerId: MarkerId(id ?? "marker $latLng"),
        position: latLng,
        onTap: () {
          mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
        },
        infoWindow: InfoWindow(
          title: street,
          snippet: address,
        ));
    setState(() {
      tempMarkers.clear();
      isTemp ? tempMarkers.add(marker) : markers.add(marker);
    });
  }

  void onTapMaps(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      placemark = place;
    });
    defineMarker(
        latLng: latLng, street: street, address: address, isTemp: true);
    mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
  }
}
