import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parking_wizard/common/models/parking_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ParkingService {
  static Database? _db;
  static final ParkingService instance = ParkingService._constructor();

  final String _tableName = 'parking';
  final String _idColumnName = 'id';
  final String _titleColumnName = 'title';
  final String _imageColumnName = 'imageUrls';
  final String _parkingTimeColumnName = 'parkingTime';
  final String _notesColumnName = 'notes';
  final String _locationColumnName = 'location';
  final String _statusColumnName = 'status';
  final String _latitudeColumnName = 'latitude';
  final String _longitudeColumnName = 'longitude';

  ParkingService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "parking_wizard.db");

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName(
            $_idColumnName INTEGER PRIMARY KEY,
            $_titleColumnName TEXT NOT NULL,
            $_imageColumnName TEXT NOT NULL,
            $_parkingTimeColumnName TEXT NOT NULL,
            $_notesColumnName TEXT NOT NULL,
            $_locationColumnName TEXT NOT NULL,
            $_statusColumnName INTEGER NOT NULL,
            $_latitudeColumnName REAL,
            $_longitudeColumnName REAL
          )
        ''');
      },
    );
    return database;
  }

  Future<void> createParking(ParkingSpot spot) async {
    final db = await database;

    await db.insert(_tableName, {
      // _titleColumnName: title,
      _titleColumnName: spot.title,
      // _imageColumnName: imageUrls,
      _imageColumnName: jsonEncode([
        "https://i.pinimg.com/736x/cb/38/6a/cb386ad02edb00c831e32643b2e7f306.jpg",
      ]),
      _parkingTimeColumnName: spot.parkingTime.toIso8601String(),
      _notesColumnName: spot.notes,
      _locationColumnName: spot.location,
      _statusColumnName: 1,
      _latitudeColumnName: 1,
      _longitudeColumnName: 1,
    });
  }

  Future<List<ParkingSpot>> getParking() async {
    final db = await database;
    final data = await db.query(_tableName);

    return data.map((map) => ParkingSpot.fromMap(map)).toList();
  }

  Future<void> deleteParking(ParkingSpot spot) async {
    final db = await database;

    await db.delete(_tableName, where: 'id = ?', whereArgs: [spot.id]);
  }

  Future<void> clearAllParkings() async {
    final db = await database; // your getter to get the DB instance
    await db.delete(_tableName); // your table name here
  }
}
