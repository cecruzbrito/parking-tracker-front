import 'package:estacionamento_rotativo/app/shared/domain/entities/vehicle_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../shared/presentation/widgets/app_bar_default.dart';
import '../../../../../shared/presentation/widgets/button_app.dart';
import '../../../../../shared/presentation/widgets/field_app.dart';
import '../../../../../shared/presentation/widgets/scaffold_app.dart';
import '../state/sign_up_add_vehicle_page_state.dart';
import '../store/sign_up_add_vehicle_page_store.dart';

class SingUpAddVehiclePage extends StatefulWidget {
  const SingUpAddVehiclePage({super.key, required this.store, this.vehicle});
  final VehicleEntity? vehicle;
  final SingUpAddVehiclePageStore store;

  @override
  State<SingUpAddVehiclePage> createState() => _SingUpAddVehiclePageState();
}

class _SingUpAddVehiclePageState extends State<SingUpAddVehiclePage> with ValidatorAddVehicle {
  SingUpAddVehiclePageStore get store => widget.store;
  VehicleEntity? get vehicle => widget.vehicle;

  @override
  void initState() {
    super.initState();
    store.initializing(vehicle);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TripleBuilder<SingUpAddVehiclePageStore, SingUpAddVehiclePageState>(
        store: store,
        builder: (_, trp) {
          return ScaffoldApp(
              settingsAppBar: AppBarDefault(
                  settings: AppBarSettings(
                      title: trp.state.vehicle != null ? "Edite seu veiculo" : "Adicione veículo",
                      onTapBack: Modular.to.pop)),
              isLoading: trp.isLoading,
              body: Form(
                key: store.formKey,
                child: Center(
                    child: SingleChildScrollView(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(trp.state.vehicle != null ? "Edite seu veiculo" : "Adicione veículo",
                      style: TextStyle(fontSize: size.height * .05)),
                  SizedBox(height: size.height * .04),
                  FieldApp(
                    settings: SettingsFieldApp(
                        validator: validaotorEmpty,
                        ctr: store.ctrLicensePlate,
                        prefixIcon: Icons.badge,
                        labelText: "Placa"),
                  ),
                  SizedBox(height: size.height * .02),
                  FieldApp(
                    settings: SettingsFieldApp(
                        validator: validaotorEmpty,
                        ctr: store.ctrModel,
                        prefixIcon: Icons.directions_car,
                        labelText: "Modelo"),
                  ),
                  SizedBox(height: size.height * .02),
                  FieldApp(
                    settings: SettingsFieldApp(
                        validator: validaotorEmpty,
                        ctr: store.ctrColor,
                        prefixIcon: Icons.format_color_fill,
                        labelText: "Cor"),
                  ),
                  SizedBox(height: size.height * .02),
                  SizedBox(width: double.infinity, child: ButtonApp(label: "Adicionar", onTap: store.onTapInAdicionar)),
                ]))),
              ));
        });
  }
}

mixin ValidatorAddVehicle {
  final String _message = "Campo obrigatorio";

  String? validaotorEmpty(String? value) {
    if (value == null) return _message;
    if (value.isEmpty) return _message;
    return null;
  }
}
