// lib/ui/screens/parking/parking_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:parking_wizard/common/models/parking_model.dart';
import 'dart:io';
import 'package:intl/intl.dart';
// TODO: Replace the import below with the correct path if different
// Make sure that the OpenStreetMap widget is defined in the imported file.
// If OpenStreetMap is not defined, define it as a widget or replace it with a valid widget.

class ParkingDetailScreen extends StatelessWidget {
  final ParkingSpot parkingSpot;

  const ParkingDetailScreen({super.key, required this.parkingSpot});

  @override
  Widget build(BuildContext context) {
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
            Text(parkingSpot.location, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text('Parked at: ${DateFormat('MMM d, y - h:mm a').format(parkingSpot.parkingTime)}'),
            if (parkingSpot.notes.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('Notes: ${parkingSpot.notes}'),
            ],
            if (parkingSpot.imageUrls.isNotEmpty) ...[
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: parkingSpot.imageUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.file(File(parkingSpot.imageUrls[index])),
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