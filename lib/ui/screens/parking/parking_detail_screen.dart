// lib/ui/screens/parking/parking_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_wizard/common/models/parking_model.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:parking_wizard/common/service/parking_service.dart';
import 'package:parking_wizard/ui/screens/save_screen.dart';
// TODO: Replace the import below with the correct path if different
// Make sure that the OpenStreetMap widget is defined in the imported file.
// If OpenStreetMap is not defined, define it as a widget or replace it with a valid widget.

class ParkingDetailScreen extends ConsumerStatefulWidget {
  final ParkingSpot parkingSpot;

  const ParkingDetailScreen({super.key, required this.parkingSpot});

  @override
  ConsumerState<ParkingDetailScreen> createState() =>
      _ParkingDetailScreenState();
}

class _ParkingDetailScreenState extends ConsumerState<ParkingDetailScreen> {
  final ParkingService _databaseService = ParkingService.instance;

  late ParkingSpot _parkingSpot;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadParkingSpot();
  }

  Future<void> _loadParkingSpot() async {
    final id = widget.parkingSpot.id;
    if (id == null) {
      // Handle error (e.g., show a message, use fallback)
      setState(() {
        _parkingSpot = widget.parkingSpot;
        _isLoading = false;
      });
      return;
    }
    final spot = await _databaseService.getParkingId(id);
    setState(() {
      _parkingSpot = spot;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final parkingItem = ref.read(activeSaveScreenItemProvider);
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Parking Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // Replace OpenStreetMap with a valid widget if it's not defined.
              // Example placeholder if OpenStreetMap is missing:
              child: Container(
                height: 200,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Text('Map preview unavailable'),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _parkingSpot.location,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'Parked at: ${DateFormat('MMM d, y - h:mm a').format(_parkingSpot.parkingTime)}',
            ),
            if (_parkingSpot.notes.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('Notes: ${_parkingSpot.notes}'),
            ],
            if (_parkingSpot.imageUrls.isNotEmpty) ...[
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _parkingSpot.imageUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.file(File(_parkingSpot.imageUrls[index])),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
