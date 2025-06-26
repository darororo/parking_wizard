import 'package:parking_wizard/data/models/location_model_db.dart';
import '../database/database_helper.dart';

class LocationRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Create
  Future<int> insertLocation(LocationModelDB location) async {
    final db = await _databaseHelper.database;
    return await db.insert('locations', location.toMap());
  }

  // Read
  Future<List<LocationModelDB>> getAllLocations() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'locations',
      orderBy: 'created_at DESC',
    );
    return List.generate(maps.length, (i) => LocationModelDB.fromMap(maps[i]));
  }

  Future<List<LocationModelDB>> getFavoriteLocations() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'locations',
      where: 'is_favorite = ?',
      whereArgs: [1],
      orderBy: 'created_at DESC',
    );
    return List.generate(maps.length, (i) => LocationModelDB.fromMap(maps[i]));
  }

  Future<LocationModelDB?> getLocationById(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'locations',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return LocationModelDB.fromMap(maps.first);
    }
    return null;
  }

  // Update
  Future<int> updateLocation(LocationModelDB location) async {
    final db = await _databaseHelper.database;
    return await db.update(
      'locations',
      location.copyWith(updatedAt: DateTime.now()).toMap(),
      where: 'id = ?',
      whereArgs: [location.id],
    );
  }

  Future<int> toggleFavorite(int id) async {
    final db = await _databaseHelper.database;
    final location = await getLocationById(id);
    if (location != null) {
      return await db.update(
        'locations',
        {
          'is_favorite': location.isFavorite ? 0 : 1,
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    }
    return 0;
  }

  // Delete
  Future<int> deleteLocation(int id) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      'locations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Search
  Future<List<LocationModelDB>> searchLocations(String query) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'locations',
      where: 'name LIKE ? OR address LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'created_at DESC',
    );
    return List.generate(maps.length, (i) => LocationModelDB.fromMap(maps[i]));
  }
}
