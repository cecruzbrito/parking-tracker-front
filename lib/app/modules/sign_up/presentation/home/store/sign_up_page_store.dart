import 'package:estacionamento_rotativo/app/modules/login/domain/entity/user_credential_entity.dart';
import 'package:estacionamento_rotativo/app/shared/domain/errors/erros.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../state/sign_up_page_state.dart';

class SingUpPageStore extends Store<SignUpPageState> {
  SingUpPageStore() : super(SignUpPageState.initialState);

  final ctrNome = TextEditingController();
  final ctrEmail = TextEditingController();
  final ctrSenha = TextEditingController();
  final ctrContato = TextEditingController();

  final keyForms = GlobalKey<FormState>();

  void initializing(UserCredentialEntity? user) {
    if (user == null) return;
    if (user.nome != null) ctrNome.text = user.nome!;
    ctrEmail.text = user.email;
  }

  Future<void> onTapAddCar() async =>
      update(state.copyWith(vehicle: await Modular.to.pushNamed("/sign_up/add_vehicle")));

  Future<void> onTapInEditVehicle() async =>
      update(state.copyWith(vehicle: await Modular.to.pushNamed("/sign_up/add_vehicle", arguments: state.vehicle)));

  void onTapShowPassword() => update(state.copyWith(hasShowPassoword: !state.hasShowPassoword));

  Future<void> onTapCadastrar() async {
    if (keyForms.currentState == null) return;
    if (!keyForms.currentState!.validate()) return;
    if (state.vehicle == null) return setError(const DomainFailure("Adicione um veiculo"), force: true);
  }
}
