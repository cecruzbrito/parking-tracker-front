class VehicleEntity {
  final int id;
  final int idClient;
  final String color;
  final String model;
  final String licensePlate;

  VehicleEntity(
      {required this.color, required this.model, required this.licensePlate, required this.idClient, required this.id});
}
