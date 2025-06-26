import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parking_wizard/common/models/parking_model.dart';
import 'package:parking_wizard/common/service/parking_service.dart';

class SaveScreen extends StatefulWidget {
  final String title;
  const SaveScreen({super.key, required this.title});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final ParkingService _databaseService = ParkingService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _parkingList(),
    );
  }

  Widget _parkingList() {
    return FutureBuilder<List<ParkingSpot>>(
      future: _databaseService.getParking(), // You need to implement this
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No parking spots saved.'));
        }

        final spots = snapshot.data!;

        return ListView.builder(
          itemCount: spots.length,
          itemBuilder: (context, index) {
            final spot = spots[index];
            return ListTile(
              leading: (spot.imageUrls != null && spot.imageUrls.isNotEmpty)
                  ? spot.imageUrls[0].startsWith('http')
                        ? Image.network(
                            spot.imageUrls[0],
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(spot.imageUrls[0]),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                  : const Icon(Icons.local_parking),
              title: Text(spot.title),
              subtitle: Text(spot.notes),
              trailing: Text(spot.parkingTime.toLocal().toString()),
            );
          },
        );
      },
    );
  }
}
