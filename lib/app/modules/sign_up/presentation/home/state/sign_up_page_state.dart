// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:estacionamento_rotativo/app/modules/sign_up/domain/entities/user_request_create_entity.dart';

import '../../../domain/entities/vehicle_view_entity.dart';

class SignUpPageState {
  static SignUpPageState initialState = SignUpPageState(hasShowPassoword: false);

  bool hasShowPassoword;
  VehicleViewEntity? vehicle;
  UserRequestCreateEntity? request;

  SignUpPageState({required this.hasShowPassoword, this.vehicle, this.request});

  SignUpPageState copyWith({
    bool? hasShowPassoword,
    VehicleViewEntity? vehicle,
    UserRequestCreateEntity? request,
  }) {
    return SignUpPageState(
      hasShowPassoword: hasShowPassoword ?? this.hasShowPassoword,
      vehicle: vehicle ?? this.vehicle,
      request: request ?? this.request,
    );
  }
}
