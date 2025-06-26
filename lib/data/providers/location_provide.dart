import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_wizard/data/models/location_model_db.dart';
import 'package:parking_wizard/data/repositories/location_repository.dart';

final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  return LocationRepository();
});

final allLocationsProvider = FutureProvider<List<LocationModelDB>>((ref) async {
  final repository = ref.read(locationRepositoryProvider);
  return repository.getAllLocations();
});

final favoriteLocationsProvider = FutureProvider<List<LocationModelDB>>((ref) async {
  final repository = ref.read(locationRepositoryProvider);
  return repository.getFavoriteLocations();
});