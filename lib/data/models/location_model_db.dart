class LocationModelDB {
  const LocationModelDB({
    this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.address,
    this.isFavorite = false,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String name;
  final double latitude;
  final double longitude;
  final String? address;
  final bool isFavorite;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'is_favorite': isFavorite ? 1 : 0,
      'created_at': (createdAt ?? DateTime.now()).toIso8601String(),
      'updated_at': (updatedAt ?? DateTime.now()).toIso8601String(),
    };
  }

  factory LocationModelDB.fromMap(Map<String, dynamic> map) {
    return LocationModelDB(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      address: map['address'],
      isFavorite: map['is_favorite'] == 1,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  LocationModelDB copyWith({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    String? address,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LocationModelDB(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}