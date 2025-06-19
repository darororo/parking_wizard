import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapLocation {
  const MapLocation({
    required this.location,
    required this.currentLocation,
    required this.destination,
    required this.route,
    this.isLoading = true,
  });

  final Location location;
  final bool isLoading;
  final LatLng? currentLocation;
  final LatLng? destination;
  final List<LatLng> route;
}
