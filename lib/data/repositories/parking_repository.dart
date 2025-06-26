import 'package:parking_wizard/common/enums/parking_status.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/parking_model_db.dart';

class ParkingRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Create
  Future<int> insertParking(ParkingModelDB parking) async {
    final db = await _databaseHelper.database;
    return await db.insert('parking', parking.toMap());
  }

  // Read
  Future<List<ParkingModelDB>> getAllParking() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'parking',
      orderBy: 'created_at DESC',
    );
    return List.generate(maps.length, (i) => ParkingModelDB.fromMap(maps[i]));
  }

  Future<ParkingModelDB?> getParkingById(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'parking',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ParkingModelDB.fromMap(maps.first);
    }
    return null;
  }

  Future<List<ParkingModelDB>> getParkingByStatus(ParkingStatus status) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'parking',
      where: 'status = ?',
      whereArgs: [status.name],
      orderBy: 'created_at DESC',
    );
    return List.generate(maps.length, (i) => ParkingModelDB.fromMap(maps[i]));
  }

  // Update
  Future<int> updateParking(ParkingModelDB parking) async {
    final db = await _databaseHelper.database;
    return await db.update(
      'parking',
      parking.copyWith(updatedAt: DateTime.now()).toMap(),
      where: 'id = ?',
      whereArgs: [parking.id],
    );
  }

  Future<int> updateParkingStatus(int id, ParkingStatus status) async {
    final db = await _databaseHelper.database;
    return await db.update(
      'parking',
      {
        'status': status.name,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete
  Future<int> deleteParking(int id) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      'parking',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllParking() async {
    final db = await _databaseHelper.database;
    return await db.delete('parking');
  }

  // Search
  Future<List<ParkingModelDB>> searchParking(String query) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'parking',
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'created_at DESC',
    );
    return List.generate(maps.length, (i) => ParkingModelDB.fromMap(maps[i]));
  }

  // Statistics
  Future<Map<String, int>> getParkingStats() async {
    final db = await _databaseHelper.database;
    final total = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM parking')
    ) ?? 0;

    final parking = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM parking WHERE status = ?', ['parking'])
    ) ?? 0;

    final done = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM parking WHERE status = ?', ['done'])
    ) ?? 0;

    return {
      'total': total,
      'parking': parking,
      'done': done,
    };
  }
}
