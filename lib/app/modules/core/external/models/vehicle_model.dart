import 'package:estacionamento_rotativo/app/modules/core/domain/entities/vehicle_entity.dart';

class VehicleModel extends VehicleEntity {
  VehicleModel(
      {required super.color,
      required super.model,
      required super.licensePlate,
      required super.idClient,
      required super.id});

  factory VehicleModel.from(Map map) => VehicleModel(
      color: map["cor"],
      model: map["modelo"],
      licensePlate: map['placa'],
      id: map["id_veiculo"],
      idClient: map["id_cliente"]);

  Map<String, dynamic> toMap() =>
      {"cor": color, "modelo": model, "placa": licensePlate, "id_veiculo": id, "id_cliente": idClient};
}
