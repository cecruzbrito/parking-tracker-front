import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../../../shared/presentation/colors/colors_app.dart';
import '../../../../../../../../../shared/presentation/widgets/button_app.dart';

class BottomSheetCheckSpot extends StatelessWidget {
  const BottomSheetCheckSpot({super.key, required this.onTapPositive, required this.onTapNegative});
  // Não é necessario dar o pop
  final Function() onTapPositive;
  // Não é necessario dar o pop
  final Function() onTapNegative;
  show(BuildContext context) async => await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
      builder: build);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Wrap(children: [
      Column(children: [
        SizedBox(width: size.width * .05, child: const Divider(height: 10, thickness: 3)),
        Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * .05),
            margin: EdgeInsets.symmetric(
              vertical: size.height * .05,
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("Confirma que o veiculo da placa XXXXXXX está presente vaga?",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: size.height * .035)),
              SizedBox(height: size.height * .04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ButtonApp(
                        horizontal: EdgeInsets.symmetric(horizontal: size.width * .08),
                        typeOfColorApp: TypeOfColorApp.strong,
                        label: "Sim",
                        onTap: () {
                          Modular.to.pop();
                          onTapPositive();
                        }),
                  ),
                  SizedBox(width: size.width * .04),
                  Expanded(
                    child: ButtonApp(
                        horizontal: EdgeInsets.symmetric(horizontal: size.width * .08),
                        typeOfColorApp: TypeOfColorApp.weak,
                        label: "Ainda não",
                        onTap: () {
                          Modular.to.pop();
                          onTapNegative();
                        }),
                  )
                ],
              ),
              SizedBox(height: size.height * .04),
              SizedBox(
                width: double.infinity,
                child: ButtonApp(
                    horizontal: EdgeInsets.symmetric(horizontal: size.width * .08),
                    typeOfColorApp: TypeOfColorApp.weak,
                    label: "Há outro veiculo nessa vaga",
                    onTap: () {
                      Modular.to.pop();
                      onTapNegative();
                    }),
              )
            ]))
      ])
    ]);
  }
}
