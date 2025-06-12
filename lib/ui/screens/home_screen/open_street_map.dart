import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMapWidget extends StatefulWidget {
  const OpenStreetMapWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OpenStreetMapWidgetState();
  }
}

class _OpenStreetMapWidgetState extends State<OpenStreetMapWidget> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: LatLng(11.57, 104.89),
            initialZoom: 19,
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
                markerDirection: MarkerDirection.heading,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
