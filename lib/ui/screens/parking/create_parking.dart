import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parking_wizard/common/models/parking_model.dart';
import 'package:parking_wizard/data/database/database_helper.dart';
import 'package:parking_wizard/ui/screens/home_screen/home_screen.dart';
import 'package:parking_wizard/ui/screens/open_street_map.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CreateParkingScreen extends StatefulWidget {
  const CreateParkingScreen({super.key});

  @override
  State<CreateParkingScreen> createState() => _CreateParkingScreenState();
}

class _CreateParkingScreenState extends State<CreateParkingScreen> {
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  String _selectedLocation = "Balaşılır amaniam Salai"; // Default location
  final List<String> _imagePaths = [];
  Position? _currentPosition;
  bool _isLoadingLocation = true;
  bool _isSaving = false;

  final dbHelper = DatabaseHelper();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _insertSampleData() async {
    try {
      await dbHelper.insertSampleData(); // Now this works - public method
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sample data inserted successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error inserting sample data: ${e.toString()}")),
      );
    }
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
      appBar: AppBar(
        title: const Text(
          'Save Parking',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Current Location Status
            if (_isLoadingLocation)
              const LinearProgressIndicator()
            else if (_currentPosition == null)
              Text(
                "Location not available",
                style: TextStyle(
                  color: Colors.red[400],
                  fontFamily: 'Montserrat',
                ),
              ),
            const SizedBox(height: 10),

            // Map Container
            Container(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              height: MediaQuery.sizeOf(context).height * 0.25,
              child: OpenStreetMapWidget(
                currentLocation: _currentPosition,
                onLocationSelected: (location) {
                  setState(() => _selectedLocation = location);
                },
              ),
            ),

            ElevatedButton(
              onPressed: _takePhoto,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue.shade400,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blue.shade400),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Take Photo",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Vehicle Photo Preview
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _imagePaths.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _imagePaths.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(File(_imagePaths[index])),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        "Vehicle Photo Preview",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 20),

            // Notes Section
            const Text(
              "Notes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Time ${DateFormat('h:mm a').format(DateTime.now())}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                hintText: "Type Something...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 30),

            // Save Parking Button
            ElevatedButton(
              onPressed: _insertData,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade400,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Save Parking",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (photo != null) {
        setState(() {
          _imagePaths.add(photo.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error taking photo: ${e.toString()}")),
      );
    }
  }

  void _saveParking() {
    if (_selectedLocation.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select a location")));
      return;
    }

    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Current location not available")),
      );
      return;
    }

    final parkingSpot = ParkingSpot(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Parking at $_selectedLocation',
      description: _notesController.text,
      location: _selectedLocation,
      notes: _notesController.text,
      parkingTime: DateTime.now(),
      imageUrls: _imagePaths,
      currentPosition: _currentPosition,
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HomeScreen(title: 'Parking Wizard', parkingSpot: parkingSpot),
      ),
      (route) => false,
    );
  }

  Future<void> _insertData() async {
    if (_selectedLocation.isEmpty ||
        _selectedLocation == "Balaşılır amaniam Salai") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a location on the map")),
      );
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("P: $_currentPosition")));
    print("P: $_currentPosition");
    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Current location not available")),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final now = DateTime.now();
      final parkingData = {
        'title': 'Parking at $_selectedLocation',
        'description': _notesController.text.trim().isEmpty
            ? 'No description provided'
            : _notesController.text.trim(),
        'image_urls': jsonEncode(_imagePaths),
        'latitude': _currentPosition?.latitude,
        'longitude': _currentPosition?.longitude,
        'status': 'parking',
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };
      print("$parkingData : data");

      final id = await dbHelper.insertData('parking', parkingData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Parking saved successfully! ID: $id")),
        );
        // Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving parking: ${e.toString()}")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    _titleController.dispose();

    super.dispose();
  }
}
