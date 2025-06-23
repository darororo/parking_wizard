import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<bool> requestLocationPermission() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return false; // Handle disabled services (e.g., show a dialog)
      }

      // Check current permission status
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false; // User denied permission
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return false; // User permanently denied (guide to app settings)
      }

      return true; // Permission granted
    } catch (e) {
      return false;
    }
  }

  static Future<Position?> getCurrentLocation() async {
    if (await requestLocationPermission()) {
      return await Geolocator.getCurrentPosition();
    }
    return null;
  }
}