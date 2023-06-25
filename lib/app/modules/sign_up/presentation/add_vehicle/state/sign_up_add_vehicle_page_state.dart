// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:estacionamento_rotativo/app/shared/domain/entities/vehicle_entity.dart';

class SingUpAddVehiclePageState {
  final VehicleEntity? vehicle;
  SingUpAddVehiclePageState({this.vehicle});

  static SingUpAddVehiclePageState initialState = SingUpAddVehiclePageState();

  SingUpAddVehiclePageState copyWith({
    VehicleEntity? vehicle,
  }) {
    return SingUpAddVehiclePageState(
      vehicle: vehicle ?? this.vehicle,
    );
  }
}
