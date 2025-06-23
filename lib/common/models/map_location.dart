import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapLocation {
  const MapLocation({
    required this.locationData,
    required this.currentLocation,
    required this.destination,
    required this.route,
    this.isLoading = true,
  });

  final LocationData locationData;
  final bool isLoading;
  final LatLng? currentLocation;
  final LatLng? destination;
  final List<LatLng> route;
}
