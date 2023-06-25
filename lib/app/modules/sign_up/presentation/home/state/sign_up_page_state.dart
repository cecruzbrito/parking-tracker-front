// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:estacionamento_rotativo/app/shared/domain/entities/vehicle_entity.dart';

class SignUpPageState {
  static SignUpPageState initialState = SignUpPageState(hasShowPassoword: false);

  bool hasShowPassoword;
  VehicleEntity? vehicle;

  SignUpPageState({required this.hasShowPassoword, this.vehicle});

  SignUpPageState copyWith({
    bool? hasShowPassoword,
    VehicleEntity? vehicle,
  }) {
    return SignUpPageState(
      hasShowPassoword: hasShowPassoword ?? this.hasShowPassoword,
      vehicle: vehicle ?? this.vehicle,
    );
  }
}
