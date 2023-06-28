import 'package:estacionamento_rotativo/app/modules/login/domain/entity/user_credential_entity.dart';
import 'package:estacionamento_rotativo/app/modules/sign_up/domain/entities/user_request_create_entity.dart';
import 'package:estacionamento_rotativo/app/shared/domain/errors/erros.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../shared/presentation/widgets/snack_bar_success.dart';
import '../../../domain/usecases/sing_up_usecase_sing_up/sing_up_usecase_sing_up_imp.dart';
import '../state/sign_up_page_state.dart';

class SingUpPageStore extends Store<SignUpPageState> {
  SingUpPageStore(this._singUpUsecase) : super(SignUpPageState.initialState);

  final SingUpUsecaseSignUpImp _singUpUsecase;

  final ctrNome = TextEditingController();
  final ctrEmail = TextEditingController();
  final ctrSenha = TextEditingController();
  final ctrContato = TextEditingController();

  final keyScaffold = GlobalKey<ScaffoldState>();

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

    update(state.copyWith(
        request: UserRequestCreateEntity(
            nome: ctrNome.text,
            email: ctrEmail.text,
            senha: ctrSenha.text,
            contato: ctrContato.text,
            vehicle: state.vehicle!)));

    setLoading(true);
    final response = await _singUpUsecase(state.request!);
    setLoading(false);

    response.fold((l) => setError(l, force: true), _successCallback);
  }

  _successCallback(void response) {
    const SnackBarSuccess(
      msg: "Usuario criado com sucesso!",
    ).show(keyScaffold.currentContext!);

    Modular.to.popUntil(ModalRoute.withName("/"));
  }
}
