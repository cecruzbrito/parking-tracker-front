import 'package:estacionamento_rotativo/app/modules/sign_up/domain/entities/vehicle_view_entity.dart';

class VehicleViewModel {
  static Map<String, String> toMap(VehicleViewEntity vehicle) => {
        "cor": vehicle.color,
        "modelo": vehicle.model,
        "placa": vehicle.licensePlate,
      };
}
