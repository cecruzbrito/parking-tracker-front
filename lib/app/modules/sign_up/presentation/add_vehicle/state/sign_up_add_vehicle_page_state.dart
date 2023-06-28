import '../../../domain/entities/vehicle_view_entity.dart';

class SingUpAddVehiclePageState {
  final VehicleViewEntity? vehicle;
  SingUpAddVehiclePageState({this.vehicle});

  static SingUpAddVehiclePageState initialState = SingUpAddVehiclePageState();

  SingUpAddVehiclePageState copyWith({
    VehicleViewEntity? vehicle,
  }) {
    return SingUpAddVehiclePageState(
      vehicle: vehicle ?? this.vehicle,
    );
  }
}
