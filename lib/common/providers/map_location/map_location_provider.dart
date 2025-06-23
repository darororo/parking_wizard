import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:parking_wizard/common/models/map_location.dart';

class MapLocationNotifier extends StateNotifier<MapLocation> {
  MapLocationNotifier()
    : super(
        MapLocation(
          locationData: LocationData.fromMap({}),
          currentLocation: null,
          destination: null,
          route: [],
        ),
      );

  // Future<void> _initLocation() async {
  //   if (!await _checkRequestPermissions()) return;

  //   state.location.onLocationChanged.listen((LocationData locationData) {
  //     if (locationData.latitude != null && locationData.longitude != null) {
  //       state.currentLocation = c LatLng(
  //         locationData.latitude!,
  //         locationData.longitude!,
  //       );

  //       isLoading = false; // stop loading once the location is obtained
  //     }
  //   });
  // }
}

final mapLocationProvider =
    StateNotifierProvider<MapLocationNotifier, MapLocation>((ref) {
      return MapLocationNotifier();
    });
