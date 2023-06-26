import 'package:estacionamento_rotativo/app/modules/core/domain/entities/parking_space_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../../shared/presentation/colors/colors_app.dart';
import '../../../../../../../../../shared/presentation/widgets/button_app.dart';

class BottomSheetParkingSpace extends StatelessWidget {
  const BottomSheetParkingSpace(
      {super.key, required this.park, required this.onTapInformThatExit, required this.onTapInformThatArrived});
  // Não é necessario dar o pop
  final Function() onTapInformThatExit;
  // Não é necessario dar o pop
  final Function() onTapInformThatArrived;
  final ParkingSpaceEntity park;
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
                  Text("Vaga reservada", textAlign: TextAlign.center, style: TextStyle(fontSize: size.height * .035)),
                  const Divider(),
                  SizedBox(height: size.height * .02),
                  Text(
                      "Data da reserva: ${DateFormat('dd/MM/yy - HH:mm:ss').format(park.endReserved!.subtract(const Duration(hours: 1, minutes: 15)))}"),
                  Text("Data do fim da reserva: ${DateFormat('dd/MM/yy - HH:mm:ss').format(park.endReserved!)}"),
                  SizedBox(height: size.height * .02),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonApp(
                          horizontal: EdgeInsets.symmetric(horizontal: size.width * .08),
                          typeOfColorApp: TypeOfColorApp.strong,
                          label: "Informar que já chegou a vaga",
                          onTap: () {
                            Modular.to.pop();
                            onTapInformThatExit();
                          }),
                      SizedBox(height: size.height * .01),
                      ButtonApp(
                          horizontal: EdgeInsets.symmetric(horizontal: size.width * .08),
                          typeOfColorApp: TypeOfColorApp.weak,
                          label: "Informar que está saiu da da vaga",
                          onTap: () {
                            Modular.to.pop();
                            onTapInformThatArrived();
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
