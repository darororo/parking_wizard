import 'dart:convert';

import 'package:parking_wizard/common/enums/parking_status.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

class ParkingSpot {
  static int _idCounter = 0; // static counter for IDs

  final int? id;
  final String title;
  final String location;
  final String notes;
  final DateTime parkingTime;
  final List<String> imageUrls;
  final ParkingStatus status;
  final double? latitude;
  final double? longitude;
  final Position? currentPosition;

  ParkingSpot({
    this.id,
    String? title,
    required this.location,
    required this.notes,
    required this.parkingTime,
    this.imageUrls = const [],
    ParkingStatus? status,
    this.latitude,
    this.longitude,
    this.currentPosition,
  }) : status = status ?? ParkingStatus.values.first,
       title = title ?? 'My Vehicle ${id ?? ++_idCounter}';

  factory ParkingSpot.fromMap(Map<String, dynamic> map) {
    return ParkingSpot(
      id: map['id'] as int?,
      location: map['location'] ?? '',
      notes: map['notes'] ?? '',
      parkingTime: DateTime.parse(map['parkingTime']),
      imageUrls: map['imageUrls'] != null
          ? List<String>.from(jsonDecode(map['imageUrls']))
          : [],
      status: ParkingStatus.values[map['status'] ?? 0],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'location': location,
      'notes': notes,
      'parkingTime': parkingTime.toIso8601String(),
      'imageUrls': jsonEncode(imageUrls),
      'status': status.index,
      'latitude': latitude,
      'longitude': longitude,
    };

    // Only include id when updating (not needed on insert)
    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
