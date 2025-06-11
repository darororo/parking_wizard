import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_wizard/ui/screens/home_screen/widgets/cat_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(11.57, 104.89);

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const CatBottomSheet(),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          // Vehicle Button
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  border: BoxBorder.all(width: 1, color: Colors.grey.shade800),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              IconButton(
                onPressed: _openBottomSheet,
                icon: const Icon(Icons.pedal_bike_rounded),
              ),
            ],
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _center, zoom: 16.0),
      ),
    );
  }
}
