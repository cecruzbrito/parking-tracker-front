import 'package:estacionamento_rotativo/app/shared/presentation/colors/colors_app.dart';
import 'package:estacionamento_rotativo/app/shared/presentation/widgets/button_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BottomSheetReserveSpot extends StatelessWidget {
  const BottomSheetReserveSpot({super.key, required this.onTapPositive, required this.onTapNegative});
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
    return Wrap(
      children: [
        Column(
          children: [
            SizedBox(width: size.width * .05, child: const Divider(height: 10, thickness: 3)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * .05),
              margin: EdgeInsets.symmetric(
                vertical: size.height * .05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Deseja reservar esta vaga?",
                      textAlign: TextAlign.center, style: TextStyle(fontSize: size.height * .035)),
                  SizedBox(height: size.height * .04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonApp(
                          horizontal: EdgeInsets.symmetric(horizontal: size.width * .08),
                          typeOfColorApp: TypeOfColorApp.strong,
                          label: "Sim",
                          onTap: () {
                            Modular.to.pop();
                            onTapPositive();
                          }),
                      SizedBox(width: size.width * .04),
                      ButtonApp(
                          horizontal: EdgeInsets.symmetric(horizontal: size.width * .08),
                          typeOfColorApp: TypeOfColorApp.weak,
                          label: "Não",
                          onTap: () {
                            Modular.to.pop();
                            onTapNegative();
                          }),
                    ],
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
