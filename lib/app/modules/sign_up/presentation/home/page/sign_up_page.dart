import 'package:estacionamento_rotativo/app/modules/login/domain/entity/user_credential_entity.dart';
import 'package:estacionamento_rotativo/app/shared/domain/errors/erros.dart';
import 'package:estacionamento_rotativo/app/shared/presentation/widgets/scaffold_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../shared/presentation/widgets/app_bar_default.dart';
import '../../../../../shared/presentation/widgets/button_app.dart';
import '../../../../../shared/presentation/widgets/field_app.dart';
import '../../../../../shared/presentation/widgets/snack_bar_error.dart';
import '../state/sign_up_page_state.dart';
import '../store/sign_up_page_store.dart';
import 'widgets/vehicle_details.dart';
import 'widgets/button_add_car.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.store, this.user});
  final SingUpPageStore store;
  final UserCredentialEntity? user;
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with ValidatorSignUpPage {
  UserCredentialEntity? get user => widget.user;
  SingUpPageStore get store => widget.store;

  @override
  void initState() {
    super.initState();
    store.observer(onError: (e) => SnackBarError(msgError: (e as AppFailure).message).setError(context));
    store.initializing(user);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TripleBuilder<SingUpPageStore, SignUpPageState>(
        store: store,
        builder: (context, trp) {
          return ScaffoldApp(
              settingsAppBar: AppBarDefault(settings: AppBarSettings(title: "Cadastro", onTapBack: Modular.to.pop)),
              isLoading: trp.isLoading,
              body: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: store.keyForms,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(user == null ? "Faça o seu cadastro" : "Conclua o seu cadastro",
                          style: TextStyle(fontSize: size.height * .05)),
                      SizedBox(height: size.height * .04),
                      FieldApp(
                        settings: SettingsFieldApp(
                            validator: validatorEmpty, ctr: store.ctrNome, prefixIcon: Icons.person, labelText: "Nome"),
                      ),
                      SizedBox(height: size.height * .02),
                      FieldApp(
                        settings: SettingsFieldApp(
                            validator: validatorEmail,
                            ctr: store.ctrEmail,
                            prefixIcon: Icons.email,
                            labelText: "Email"),
                      ),
                      SizedBox(height: size.height * .02),
                      FieldApp(
                        settings: SettingsFieldApp(
                            validator: validatorEmpty,
                            hasShowText: trp.state.hasShowPassoword,
                            suffixIcon: SufixIconFieldApp(
                                icon: trp.state.hasShowPassoword ? Icons.visibility_off : Icons.visibility,
                                onTap: store.onTapShowPassword),
                            ctr: store.ctrSenha,
                            prefixIcon: Icons.lock,
                            labelText: "Senha"),
                      ),
                      SizedBox(height: size.height * .02),
                      FieldApp(
                        settings: SettingsFieldApp(
                            validator: validatorEmpty,
                            ctr: store.ctrContato,
                            prefixIcon: Icons.email,
                            labelText: "Contato"),
                      ),
                      SizedBox(height: size.height * .02),
                      trp.state.vehicle == null
                          ? ButtonAddCar(onTap: store.onTapAddCar)
                          : VehicleDetails(vehicle: trp.state.vehicle!, onTap: store.onTapInEditVehicle),
                      SizedBox(height: size.height * .02),
                      SizedBox(
                          width: double.infinity, child: ButtonApp(label: "Cadastrar", onTap: store.onTapCadastrar)),
                    ]),
                  ),
                ),
              ));
        });
  }
}

mixin ValidatorSignUpPage {
  final _message = "Campo obrigatorio";
  String? validatorEmail(String? value) {
    if (value == null) return _message;
    if (value.isEmpty) return _message;
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return "Email invalido";
    }
    return null;
  }

  String? validatorEmpty(String? value) {
    if (value == null) return _message;
    if (value.isEmpty) return _message;
    return null;
  }
}
