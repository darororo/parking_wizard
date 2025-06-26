import 'dart:convert';
import 'package:parking_wizard/common/enums/parking_status.dart';

class ParkingModelDB {
  const ParkingModelDB({
    this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    this.status = ParkingStatus.parking,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String title;
  final String description;
  final List<String> imageUrls;
  final ParkingStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Convert to Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_urls': jsonEncode(imageUrls),
      'status': status.name,
      'created_at': (createdAt ?? DateTime.now()).toIso8601String(),
      'updated_at': (updatedAt ?? DateTime.now()).toIso8601String(),
    };
  }

  // Create from Map (database result)
  factory ParkingModelDB.fromMap(Map<String, dynamic> map) {
    return ParkingModelDB(
      id: map['id']?.toInt(),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrls: List<String>.from(jsonDecode(map['image_urls'] ?? '[]')),
      status: ParkingStatus.values.firstWhere(
            (e) => e.name == map['status'],
        orElse: () => ParkingStatus.parking,
      ),
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  // Copy with method for updates
  ParkingModelDB copyWith({
    int? id,
    String? title,
    String? description,
    List<String>? imageUrls,
    ParkingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ParkingModelDB(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'ParkingModelDB(id: $id, title: $title, description: $description, imageUrls: $imageUrls, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ParkingModelDB &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.imageUrls.toString() == imageUrls.toString() &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    title.hashCode ^
    description.hashCode ^
    imageUrls.hashCode ^
    status.hashCode;
  }
}