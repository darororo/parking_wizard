import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:parking_wizard/common/enums/parking_status.dart';
import 'package:parking_wizard/common/models/parking_model.dart';
import 'package:parking_wizard/common/service/parking_service.dart';
import 'package:parking_wizard/ui/screens/open_street_map.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class CreateParkingScreen extends StatefulWidget {
  const CreateParkingScreen({super.key});

  @override
  State<CreateParkingScreen> createState() => _CreateParkingScreenState();
}

class _CreateParkingScreenState extends State<CreateParkingScreen> {
  final ParkingService _databaseService = ParkingService.instance;

  String? _notesText = '';

  final TextEditingController _notesController = TextEditingController();
  String _selectedLocation = "Balaşılır amaniam Salai"; // Default location
  final List<String> _imagePaths = [];
  Position? _currentPosition;
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoadingLocation = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location services are disabled")),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location permissions are denied")),
          );
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
        _isLoadingLocation = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error getting location: ${e.toString()}")),
      );
      setState(() => _isLoadingLocation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Save Parking')),
      body: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: BoxBorder.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.sizeOf(context).height * 0.25,
            child: OpenStreetMapWidget(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Vehicle Photo Preview',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Take Photo',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.camera_alt_outlined),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 220,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildImage(
                      'https://i.pinimg.com/736x/cb/38/6a/cb386ad02edb00c831e32643b2e7f306.jpg',
                    ),
                    const SizedBox(width: 12),
                    _buildImage(
                      'https://i.pinimg.com/736x/ec/e0/6e/ece06e300e3a809becbdb651d8d49299.jpg',
                    ),
                    const SizedBox(width: 12),
                    _buildImage(
                      'https://i.pinimg.com/736x/65/ae/db/65aedb82a3de3584fbba370c0a2f80a4.jpg',
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notes',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Text(
                  'Time: 6:44 PM',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              onChanged: (value) {
                _notesText = value;
              },
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Add a note about the parking',
                hintText: 'E.g., Level 2, near the elevator',
                labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: TextButton(
                onPressed: () async {
                  final spot = ParkingSpot(
                    location: _selectedLocation,
                    notes: _notesText ?? '',
                    parkingTime: DateTime.now(),
                  );

                  await _databaseService.createParking(spot);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Parking saved!')),
                  );

                  context.go('/home');
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Text(
                  'Save Parking',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    fontFamily: 'Monserrat',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(url, height: 220, width: 320, fit: BoxFit.cover),
    );
  }
}
