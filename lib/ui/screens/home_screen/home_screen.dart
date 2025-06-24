import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:parking_wizard/common/models/parking_model.dart';
import 'package:parking_wizard/common/providers/home_screen/parking_bottom_sheet_provider.dart';
import 'package:parking_wizard/ui/screens/home_screen/widgets/cat_bottom_sheet.dart';
import 'package:parking_wizard/ui/screens/open_street_map.dart';
import 'package:parking_wizard/ui/screens/parking/create_parking.dart';
import 'package:parking_wizard/ui/screens/parking/parking_detail_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String title;
  final ParkingSpot? parkingSpot;

  const HomeScreen({
    super.key,
    required this.title,
    this.parkingSpot,
  });

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Position? _currentPosition;
  List<ParkingSpot> _parkingSpots = [];

  @override
  void initState() {
    super.initState();
    _handleLocationPermission();
    if (widget.parkingSpot != null) {
      _parkingSpots.add(widget.parkingSpot!);
    }
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const CatBottomSheet(),
    );
  }

  Future<void> _handleLocationPermission() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled')),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are permanently denied, enable in app settings'),
          ),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting location: ${e.toString()}')),
      );
    }
  }

  void _navigateToCreateParking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateParkingScreen(),
      ),
    );
  }

  Widget _buildParkingSpotCard(ParkingSpot spot) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(spot.location),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat('MMM d, y - h:mm a').format(spot.parkingTime)),
            if (spot.currentPosition != null)
              Text(
                '${_formatPosition(spot.currentPosition!)}',
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ParkingDetailScreen(parkingSpot: spot),
            ),
          );
        },
      ),
    );
  }

  Widget _buildParkingInfo() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Parked at: ${widget.parkingSpot!.location}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (widget.parkingSpot!.currentPosition != null)
              Text('Current Location: ${_formatPosition(widget.parkingSpot!.currentPosition!)}'),
            const SizedBox(height: 8),
            if (widget.parkingSpot!.notes.isNotEmpty)
              Text('Notes: ${widget.parkingSpot!.notes}'),
            const SizedBox(height: 8),
            if (widget.parkingSpot!.imageUrls.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.parkingSpot!.imageUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.file(File(widget.parkingSpot!.imageUrls[index])),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatPosition(Position position) {
    return 'Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}';
  }

  @override
  Widget build(BuildContext context) {
    final toggleParkingBottomSheet = ref.watch(parkingBottomSheetProvider);

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
          // Location Button
          IconButton(
            onPressed: _handleLocationPermission,
            icon: const Icon(Icons.location_on),
            tooltip: 'Get current location',
          ),
          // Add Parking Button
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToCreateParking,
          ),
        ],
      ),
     
      floatingActionButton: FloatingActionButton(
        onPressed: _handleLocationPermission,
        child: const Icon(Icons.location_searching),
      ),
    );
  }
}