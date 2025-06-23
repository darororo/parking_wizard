import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class OpenStreetMapWidget extends StatefulWidget {
  final Position? currentLocation;
  final String? parkingLocation;
  final Function(String)? onLocationSelected;
  
  const OpenStreetMapWidget({
    super.key,
    this.currentLocation,
    this.parkingLocation,
    this.onLocationSelected,
  });

  @override
  State<OpenStreetMapWidget> createState() => _OpenStreetMapWidgetState();
}

class _OpenStreetMapWidgetState extends State<OpenStreetMapWidget> {
  final MapController _mapController = MapController();
  final TextEditingController _locationController = TextEditingController();
  final Location _locationService = Location();
  bool _isLoading = true;
  LatLng? _destination;
  List<LatLng> _route = [];
  LatLng? _currentLatLng;
  LatLng? _parkingLatLng;
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _initLocation();
    _initParkingLocation();
  }

  void _initParkingLocation() {
    if (widget.parkingLocation != null) {
      _fetchCoordinatePoints(widget.parkingLocation!);
    }
  }

  Future<void> _initLocation() async {
    if (widget.currentLocation != null) {
      setState(() {
        _currentLatLng = LatLng(
          widget.currentLocation!.latitude,
          widget.currentLocation!.longitude,
        );
        _isLoading = false;
      });
      return;
    }

    if (!await _checkRequestPermissions()) {
      setState(() => _isLoading = false);
      return;
    }

    _locationService.onLocationChanged.listen((LocationData locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        setState(() {
          _currentLatLng = LatLng(
            locationData.latitude!,
            locationData.longitude!,
          );
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _fetchCoordinatePoints(String location) async {
    setState(() => _isLoading = true);
    try {
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
            _parkingLatLng = LatLng(lat, lon);
            _destination = _parkingLatLng;
          });
          await _fetchRoute();
          _mapController.move(_parkingLatLng!, 15);
        } else {
          _showErrorMessage('Location not found');
        }
      } else {
        _showErrorMessage('Failed to fetch location');
      }
    } catch (e) {
      _showErrorMessage('Error: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<bool> _checkRequestPermissions() async {
    bool serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) return false;
    }

    PermissionStatus permissionStatus = await _locationService.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _locationService.requestPermission();
      if (permissionStatus != PermissionStatus.granted) return false;
    }

    return true;
  }

  Future<void> _userCurrentLocation() async {
    if (_currentLatLng == null) {
      await _initLocation();
    }

    if (_currentLatLng != null) {
      _mapController.move(_currentLatLng!, 15);
    } else {
      _showErrorMessage("Current Location not available");
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _fetchRoute() async {
    if (_currentLatLng == null || _destination == null) return;

    try {
      final url = Uri.parse(
        "http://router.project-osrm.org/route/v1/driving/"
        "${_currentLatLng!.longitude},${_currentLatLng!.latitude};"
        "${_destination!.longitude},${_destination!.latitude}"
        "?overview=full&geometries=polyline",
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final geometry = data['routes'][0]['geometry'];
        _decodePolyline(geometry);
      } else {
        _showErrorMessage('Failed to fetch route');
      }
    } catch (e) {
      _showErrorMessage('Route error: ${e.toString()}');
    }
  }

  void _decodePolyline(String encodedPolyline) {
    final polylinePoints = PolylinePoints();
    final decodedPoints = polylinePoints.decodePolyline(encodedPolyline);

    setState(() {
      _route = decodedPoints
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    });
  }

  void _handleMapTap(TapPosition tapPosition, LatLng latLng) {
    if (widget.onLocationSelected != null) {
      setState(() => _selectedLocation = latLng);
      widget.onLocationSelected!("${latLng.latitude},${latLng.longitude}");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      clipBehavior: Clip.antiAlias,
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _currentLatLng ?? const LatLng(11.57, 104.9),
            initialZoom: 15,
            minZoom: 0,
            maxZoom: 100,
            onTap: _handleMapTap,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.parking_wizard',
            ),
            
            // Current Location Marker
            if (_currentLatLng != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentLatLng!,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.person_pin_circle, color: Colors.blue, size: 40),
                  ),
                ],
              ),
            
            // Parking Location Marker
            if (_parkingLatLng != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _parkingLatLng!,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.local_parking, color: Colors.red, size: 40),
                  ),
                ],
              ),
            
            // Selected Location Marker (for location selection mode)
            if (_selectedLocation != null && widget.onLocationSelected != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedLocation!,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_on, color: Colors.green, size: 40),
                  ),
                ],
              ),
            
            // Route between current location and parking spot
            if (_currentLatLng != null && _parkingLatLng != null && _route.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _route,
                    strokeWidth: 5,
                    color: Colors.blue,
                  ),
                ],
              ),
          ],
        ),

        // Search UI
        if (widget.onLocationSelected == null) // Only show search when not in selection mode
          Positioned(
            top: 8,
            left: 8,
            right: 8,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    final location = _locationController.text.trim();
                    if (location.isNotEmpty) _fetchCoordinatePoints(location);
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),

        // Current location button
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: _userCurrentLocation,
            backgroundColor: Colors.blue[100],
            child: const Icon(Icons.gps_fixed_rounded),
          ),
        ),

        // Location selection confirmation button
        if (widget.onLocationSelected != null && _selectedLocation != null)
          Positioned(
            bottom: 80,
            right: 20,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                widget.onLocationSelected!(
                  "${_selectedLocation!.latitude},${_selectedLocation!.longitude}",
                );
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.check),
            ),
          ),
      ],
    );
  }
}