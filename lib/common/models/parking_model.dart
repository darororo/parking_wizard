import 'package:parking_wizard/common/enums/parking_status.dart';

class ParkingModel {
  const ParkingModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    this.status = ParkingStatus.parking,
  });

  final int id;
  final String title;
  final String description;
  final List<String> imageUrls;
  final ParkingStatus status;
}
