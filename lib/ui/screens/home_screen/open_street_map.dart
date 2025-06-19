import 'dart:convert';
import 'dart:math' as math;
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class OpenStreetMapWidget extends StatefulWidget {
  const OpenStreetMapWidget({super.key});

  @override
  State<OpenStreetMapWidget> createState() {
    return _OpenStreetMapWidgetState();
  }
}

class _OpenStreetMapWidgetState extends State<OpenStreetMapWidget> {
  final MapController _mapController = MapController();
  final TextEditingController _locationController = TextEditingController();
  final Location _location = Location();
  bool isLoading = true;
  LatLng? _destination;
  List<LatLng> _route = [];
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    if (!await _checkRequestPermissions()) return;

    _location.onLocationChanged.listen((LocationData locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        setState(() {
          _currentLocation = LatLng(
            locationData.latitude!,
            locationData.longitude!,
          );

          isLoading = false; // stop loading once the location is obtained
        });
      }
    });
  }

  Future<void> _fetchCoordinatePoints(String location) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$location&format=json&limit=1',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);

        setState(() {
          _destination = LatLng(lat, lon);
        });
        await _fetchRoute();

        _mapController.move(_currentLocation!, 6);
      } else {
        errorMessage('Location not found');
      }
    } else {
      errorMessage('Failed to fetch location');
    }
  }

  Future<bool> _checkRequestPermissions() async {
    bool serviceEnabled = await _location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    PermissionStatus permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  Future<void> _userCurrentLocation() async {
    if (_currentLocation != null) {
      _mapController.move(_currentLocation!, 15);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Current Location not available")),
      );
    }
  }

  void errorMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _fetchRoute() async {
    if (_currentLocation == null || _destination == null) return;

    final url = Uri.parse(
      "http://router.project-osrm.org/route/v1/driving/${_currentLocation!.longitude},${_currentLocation!.latitude};${_destination!.longitude},${_destination!.latitude}?overview=full&geometries=polyline",
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final geometry = data['routes'][0]['geometry'];
      _decodePolyline(geometry);
    } else {
      errorMessage('Failed to fetch route.');
    }
  }

  void _decodePolyline(String encodedPolyline) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPoints = polylinePoints.decodePolyline(
      encodedPolyline,
    );

    setState(() {
      _route = decodedPoints
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _currentLocation ?? const LatLng(11.57, 104.9),
            initialZoom: 15,
            minZoom: 0,
            maxZoom: 100,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            CurrentLocationLayer(
              style: const LocationMarkerStyle(
                marker: DefaultLocationMarker(
                  child: Icon(Icons.location_pin, color: Colors.white),
                ),
                markerSize: Size(35, 35),
                markerDirection: MarkerDirection.top,
              ),
            ),
            if (_destination != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _destination!,
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.location_on_sharp,
                      size: 40,
                      color: Colors.purple[100],
                    ),
                  ),
                ],
              ),
            if (_currentLocation != null &&
                _destination != null &&
                _route.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(points: _route, strokeWidth: 5, color: Colors.red),
                ],
              ),
          ],
        ),

        // Textfield for searching location
        Positioned(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter a text',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                    ),
                  ),
                ),

                // Search button
                IconButton(
                  style: IconButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    final location = _locationController.text.trim();
                    if (location.isNotEmpty) {
                      _fetchCoordinatePoints(location);
                    }
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
          ),
        ),

        // Move to current location button
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: _userCurrentLocation,
            backgroundColor: Colors.blue[100],
            child: Icon(Icons.gps_fixed_rounded),
          ),
        ),
      ],
    );
  }
}
