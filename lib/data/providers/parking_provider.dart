import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_wizard/data/repositories/parking_repository.dart';
import 'package:parking_wizard/common/enums/parking_status.dart';

import '../models/parking_model_db.dart';

final parkingRepositoryProvider = Provider<ParkingRepository>((ref) {
  return ParkingRepository();
});

final allParkingProvider = FutureProvider<List<ParkingModelDB>>((ref) async {
  final repository = ref.read(parkingRepositoryProvider);
  return repository.getAllParking();
});

final parkingByStatusProvider = FutureProvider.family<List<ParkingModelDB>, ParkingStatus>((ref, status) async {
  final repository = ref.read(parkingRepositoryProvider);
  return repository.getParkingByStatus(status);
});

final parkingStatsProvider = FutureProvider<Map<String, int>>((ref) async {
  final repository = ref.read(parkingRepositoryProvider);
  return repository.getParkingStats();
});

// Provider for search functionality
final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<ParkingModelDB>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];

  final repository = ref.read(parkingRepositoryProvider);
  return repository.searchParking(query);
});