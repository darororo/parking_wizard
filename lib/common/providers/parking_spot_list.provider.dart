import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_wizard/common/models/parking_model.dart';

final activeParkingSpotProvider =
    StateNotifierProvider<ParkingSpotNotifier, ParkingSpot?>(
      (ref) => ParkingSpotNotifier(),
    );

class ParkingSpotNotifier extends StateNotifier<ParkingSpot?> {
  ParkingSpotNotifier() : super(null);

  // Set the active spot
  void setActiveSpot(ParkingSpot spot) {
    state = spot;
  }

  // Clear the active spot
  void clearActiveSpot() {
    state = null;
  }
}

final parkingSpotListProvider =
    StateNotifierProvider<ParkingSpotListNotifier, List<ParkingSpot>>((ref) {
      return ParkingSpotListNotifier();
    });

class ParkingSpotListNotifier extends StateNotifier<List<ParkingSpot>> {
  ParkingSpotListNotifier() : super([]);

  void add(ParkingSpot spot) {
    state = [...state, spot];
  }

  void copy(List<ParkingSpot> spots) {
    state = spots;
  }

  // Clear the active spot
  void clearList() {
    state = [];
  }
}
