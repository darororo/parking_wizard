import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParkingBottomSheetNotifier extends StateNotifier<bool> {
  ParkingBottomSheetNotifier() : super(false);

  void toggleBottomSheet() {
    state = !state;
  }
}

final parkingBottomSheetProvider =
    StateNotifierProvider<ParkingBottomSheetNotifier, bool>((ref) {
      return ParkingBottomSheetNotifier();
    });
