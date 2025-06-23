import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parking_wizard/common/models/parking_model.dart';
import 'package:parking_wizard/ui/screens/home_screen/home_screen.dart';
import 'package:parking_wizard/ui/screens/open_street_map.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class CreateParkingScreen extends StatefulWidget {
  const CreateParkingScreen({super.key});

  @override
  State<CreateParkingScreen> createState() => _CreateParkingScreenState();
}

class _CreateParkingScreenState extends State<CreateParkingScreen> {
  final TextEditingController _notesController = TextEditingController();
  String _selectedLocation = "Balaşılır amaniam Salai"; // Default location
  List<String> _imagePaths = [];
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

            // Location Dropdown
            DropdownButtonFormField<String>(
              value: _selectedLocation,
              items: [
                "Balaşılır amaniam Salai",
                "Kamarajar Salai",
                "85th Street",
                "88th Avenue",
                "16th Avenue"
              ].map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedLocation = value!);
              },
              decoration: InputDecoration(
                labelText: 'Parking Location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Take Photo Button
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
              onPressed: _saveParking,
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
    // Implement camera functionality
    // final image = await ImagePicker().pickImage(source: ImageSource.camera);
    // if (image != null) {
    //   setState(() {
    //     _imagePaths.add(image.path);
    //   });
    // }
  }

  void _saveParking() {
    if (_selectedLocation.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a location")),
      );
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
        builder: (context) => HomeScreen(
          title: 'Parking Wizard',
          parkingSpot: parkingSpot,
        ),
      ),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}