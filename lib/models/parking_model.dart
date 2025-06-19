class ParkingModel {
  const ParkingModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
  });

  final int id;
  final String title;
  final String description;
  final List<String> imageUrls;
}
