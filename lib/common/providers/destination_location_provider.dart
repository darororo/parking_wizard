import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

final destinationLocationProvider =
    StateNotifierProvider<DestinationLocationNotifier, LatLng?>((ref) {
      return DestinationLocationNotifier();
    });

class DestinationLocationNotifier extends StateNotifier<LatLng?> {
  DestinationLocationNotifier() : super(null);
}
