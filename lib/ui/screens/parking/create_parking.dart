import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:parking_wizard/common/enums/parking_status.dart';
import 'package:parking_wizard/common/models/parking_model.dart';
import 'package:parking_wizard/common/providers/destination_location_provider.dart';
import 'package:parking_wizard/common/providers/parking_spot_list.provider.dart';
import 'package:parking_wizard/common/service/parking_service.dart';
import 'package:parking_wizard/ui/screens/open_street_map.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_wizard/common/enums/parking_status.dart';
import 'package:parking_wizard/common/models/parking_model.dart';
import 'package:parking_wizard/common/service/parking_service.dart';

class CreateParkingScreen extends ConsumerStatefulWidget {
  const CreateParkingScreen({super.key});

  @override
  ConsumerState<CreateParkingScreen> createState() =>
      _CreateParkingScreenState();
}

class _CreateParkingScreenState extends ConsumerState<CreateParkingScreen> {
  final ParkingService _databaseService = ParkingService.instance;
  final Location _locationService = Location();
  LatLng? destination;

  String? _notesText = '';

  final TextEditingController _notesController = TextEditingController();
  String _selectedLocation = "Balaşılır amaniam Salai"; // Default location
  final List<String> _imagePaths = [];

  // crud

  Position? _currentPosition;
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  List<File> _selectedImages = [];

  Future<void> _pickImageFromGallery() async {
    final List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images.map((image) => File(image.path)));
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      setState(() {
        _selectedImages.add(File(image.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
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
        forceMaterialTransparency: true,
        toolbarHeight: 50,
        leadingWidth: 40,
        title: Text(
          'Save Parking',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),

        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.sizeOf(context).height * 0.25,
                  child: OpenStreetMapWidget(),
                ),
                Positioned(
                  top: 36,
                  right: 36,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00B894),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Live',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //selct image from camera
                  TextButton(
                    onPressed: () {
                      _pickImageFromCamera();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    child: Row(
                      children: const [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.white, // White icon
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Take Photo',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white, // White text
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  // select image from gallery
                  TextButton(
                    onPressed: () {
                      _pickImageFromGallery();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.photo_library, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          _selectedImages.isNotEmpty ? 'Gallery' : 'Gallery',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (_selectedImages != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 200,
                  child: _selectedImages.isEmpty
                      ? Center(
                          child: Container(
                            width: 260,
                            height: 180,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'No images selected.',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _selectedImages.asMap().entries.map((
                              entry,
                            ) {
                              int index = entry.key;
                              File file = entry.value;
                              return Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    width: 260,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        file,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 12,
                                    right: 28,
                                    child: GestureDetector(
                                      onTap: () => _removeImage(index),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2D3436),
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00B894).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              size: 14,
                              color: Color(0xFF00B894),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat('h:mm a').format(DateTime.now()),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF00B894),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: TextFormField(
                    //crud
                    onChanged: (value) {
                      _notesText = value;
                    },

                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Add a note about the parking...',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      contentPadding: EdgeInsets.all(16),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
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
                  // onPressed: () {},
                  // crud
                  onPressed: () async {
                    final spot = ParkingSpot(
                      location: _selectedLocation,
                      notes: _notesText ?? '',
                      parkingTime: DateTime.now(),
                      latitude: destination?.latitude,
                      longitude: destination?.longitude,
                      imageUrls: _selectedImages
                          .map((file) => file.path)
                          .toList(),
                    );

                    // await _databaseService.clearAllParkings();
                    await _databaseService.createParking(spot);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Parking Saved')),
                    );

                    ref.read(parkingSpotListProvider.notifier).add(spot);

                    ref.read(destinationLocationProvider.notifier).state =
                        destination;

                    context.go('/home');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF407BFF),
                    foregroundColor: Color(0xFF407BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Save Parking',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initLocation() async {
    // if (widget.currentLocation != null) {
    //   setState(() {
    //     _currentLatLng = LatLng(
    //       widget.currentLocation!.latitude,
    //       widget.currentLocation!.longitude,
    //     );
    //     _isLoading = false;
    //   });
    //   return;
    // }

    // if (!await _checkRequestPermissions()) {
    //   setState(() => _isLoading = false);
    //   return;
    // }

    _locationService.onLocationChanged.listen((LocationData locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        destination = LatLng(locationData.latitude!, locationData.longitude!);
      }
    });
  }
}
