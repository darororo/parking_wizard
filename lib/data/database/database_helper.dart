// First, let's fix your DatabaseHelper by adding CRUD operations
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'parking_wizard.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create parking table
    await db.execute('''
      CREATE TABLE parking (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        image_urls TEXT NOT NULL,
        latitude REAL,
        longitude REAL,
        status TEXT NOT NULL DEFAULT 'parking',
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Create locations table for storing favorite/saved locations
    await db.execute('''
      CREATE TABLE locations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        address TEXT,
        is_favorite INTEGER DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Create parking_locations junction table
    await db.execute('''
      CREATE TABLE parking_locations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        parking_id INTEGER NOT NULL,
        location_id INTEGER NOT NULL,
        FOREIGN KEY (parking_id) REFERENCES parking (id) ON DELETE CASCADE,
        FOREIGN KEY (location_id) REFERENCES locations (id) ON DELETE CASCADE,
        UNIQUE(parking_id, location_id)
      )
    ''');

    // Create routes table for storing navigation routes
    await db.execute('''
      CREATE TABLE routes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        start_latitude REAL NOT NULL,
        start_longitude REAL NOT NULL,
        end_latitude REAL NOT NULL,
        end_longitude REAL NOT NULL,
        route_points TEXT NOT NULL,
        distance REAL,
        duration INTEGER,
        created_at TEXT NOT NULL
      )
    ''');

    // Insert some sample data
    await _insertSampleData(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add any future upgrades here
    }
  }

  // Generic insertData function - can be used for any table
  Future<int> insertData(String table, Map<String, dynamic> data) async {
    final db = await database;

    // Add timestamps if they don't exist
    final now = DateTime.now().toIso8601String();
    data.putIfAbsent('created_at', () => now);
    data.putIfAbsent('updated_at', () => now);

    return await db.insert(table, data);
  }

  // Generic insertDataBatch function for multiple records
  Future<void> insertDataBatch(String table, List<Map<String, dynamic>> dataList) async {
    final db = await database;
    Batch batch = db.batch();
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    for (var data in dataList) {
      // final now = DateTime.now().toIso8601String();
      // data.putIfAbsent('created_at', () => now);
      // data.putIfAbsent('updated_at', () => now);

      batch.insert(table, data);
    }

    await batch.commit();
  }

  // Generic update function
  Future<int> updateData(String table, int id, Map<String, dynamic> data) async {
    final db = await database;

    // Update the updated_at timestamp
    data['updated_at'] = DateTime.now().toIso8601String();

    return await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Generic delete function
  Future<int> deleteData(String table, int id) async {
    final db = await database;
    return await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Generic query function
  Future<List<Map<String, dynamic>>> queryData(String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final db = await database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
    );
  }

  // CRUD Operations for Parking
  Future<int> insertParking(Map<String, dynamic> parkingData) async {
    return await insertData('parking', parkingData);
  }

  Future<List<Map<String, dynamic>>> getAllParking() async {
    return await queryData('parking', orderBy: 'created_at DESC');
  }

  Future<Map<String, dynamic>?> getParkingById(int id) async {
    List<Map<String, dynamic>> results = await queryData(
      'parking',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> updateParking(int id, Map<String, dynamic> parkingData) async {
    return await updateData('parking', id, parkingData);
  }

  Future<int> deleteParking(int id) async {
    return await deleteData('parking', id);
  }

  // CRUD Operations for Locations
  Future<int> insertLocation(Map<String, dynamic> locationData) async {
    return await insertData('locations', locationData);
  }

  Future<int> insertParkingLocation(int parkingId, int locationId) async {
    return await insertData('parking_locations', {
      'parking_id': parkingId,
      'location_id': locationId,
    });
  }

  Future<List<Map<String, dynamic>>> getAllLocations() async {
    return await queryData('locations', orderBy: 'created_at DESC');
  }

  Future<Map<String, dynamic>?> getLocationById(int id) async {
    List<Map<String, dynamic>> results = await queryData(
      'locations',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> updateLocation(int id, Map<String, dynamic> locationData) async {
    return await updateData('locations', id, locationData);
  }

  Future<int> deleteLocation(int id) async {
    return await deleteData('locations', id);
  }

  // CRUD Operations for Routes
  Future<int> insertRoute(Map<String, dynamic> routeData) async {
    return await insertData('routes', routeData);
  }

  Future<List<Map<String, dynamic>>> getAllRoutes() async {
    return await queryData('routes', orderBy: 'created_at DESC');
  }

  Future<Map<String, dynamic>?> getRouteById(int id) async {
    List<Map<String, dynamic>> results = await queryData(
      'routes',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> updateRoute(int id, Map<String, dynamic> routeData) async {
    return await updateData('routes', id, routeData);
  }

  Future<int> deleteRoute(int id) async {
    return await deleteData('routes', id);
  }

  Future<void> _insertSampleData(Database db) async {
    // Insert sample data
    await db.insert('parking', {
      'title': 'Downtown Parking Garage',
      'description': 'Secure underground parking in the city center',
      'image_urls': '["https://example.com/image1.jpg", "https://example.com/image2.jpg"]',
      'status': 'parking',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    await db.insert('parking', {
      'title': 'Mall Parking Lot',
      'description': 'Large surface parking lot with easy access',
      'image_urls': '["https://example.com/image3.jpg"]',
      'status': 'done',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    // Insert sample locations
    await db.insert('locations', {
      'name': 'City Center',
      'latitude': 11.5564,
      'longitude': 104.9282,
      'address': 'Phnom Penh, Cambodia',
      'is_favorite': 1,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> insertSampleData() async {
    final db = await database;
    await _insertSampleData(db);
  }

  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}