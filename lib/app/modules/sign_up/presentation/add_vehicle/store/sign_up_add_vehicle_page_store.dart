import 'package:estacionamento_rotativo/app/shared/domain/entities/vehicle_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../state/sign_up_add_vehicle_page_state.dart';

class SingUpAddVehiclePageStore extends Store<SingUpAddVehiclePageState> {
  SingUpAddVehiclePageStore() : super(SingUpAddVehiclePageState.initialState);

  final ctrColor = TextEditingController();

  final ctrModel = TextEditingController();

  final ctrLicensePlate = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void onTapInAdicionar() {
    if (formKey.currentState == null) return;

    if (!formKey.currentState!.validate()) return;

    update(state.copyWith(
        vehicle: VehicleEntity(color: ctrColor.text, model: ctrModel.text, licensePlate: ctrLicensePlate.text)));

    Modular.to.pop(state.vehicle);
  }

  initializing(VehicleEntity? vehicle) {
    if (vehicle == null) return;
    ctrModel.text = vehicle.model;
    ctrLicensePlate.text = vehicle.licensePlate;
    ctrColor.text = vehicle.color;
    update(state.copyWith(vehicle: vehicle));
  }
}
