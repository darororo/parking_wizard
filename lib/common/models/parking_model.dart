import 'package:parking_wizard/common/enums/parking_status.dart';
import 'package:geolocator/geolocator.dart';

class ParkingSpot {
  final String id;
  final String title;
  final String description;
  final String location;
  final String notes;
  final DateTime parkingTime;
  final List<String> imageUrls;
  final ParkingStatus status;
  final double? latitude;
  final double? longitude;
  final Position? currentPosition;

  ParkingSpot({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.notes,
    required this.parkingTime,
    this.imageUrls = const [],
    ParkingStatus? status,
    this.latitude,
    this.longitude,
    this.currentPosition,
  }) : status = status ?? ParkingStatus.values.first;

  factory ParkingSpot.fromMap(Map<String, dynamic> map) {
    return ParkingSpot(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      notes: map['notes'] ?? '',
      parkingTime: DateTime.parse(map['parkingTime']),
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      status: ParkingStatus.values[map['status'] ?? 0],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'notes': notes,
      'parkingTime': parkingTime.toIso8601String(),
      'imageUrls': imageUrls,
      'status': status.index,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}