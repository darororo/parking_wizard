import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class CurrentLocationNotifier extends StateNotifier<LatLng?> {
  CurrentLocationNotifier() : super(null);

  updateLocation(LatLng? location) {
    state = location;
  }
}

final currentLcationNotifierProvider =
    StateNotifierProvider<CurrentLocationNotifier, LatLng?>((ref) {
      return CurrentLocationNotifier();
    });
