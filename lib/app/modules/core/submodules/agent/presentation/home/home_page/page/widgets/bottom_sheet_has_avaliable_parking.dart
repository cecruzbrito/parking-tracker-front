import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../../../shared/presentation/colors/colors_app.dart';
import '../../../../../../../../../shared/presentation/widgets/button_app.dart';
import '../../../../../../../domain/entities/parking_space_entity.dart';

class BottomSheetHasAvaliableParking extends StatelessWidget {
  const BottomSheetHasAvaliableParking({super.key, required this.park, required this.onTapAvaliable});
  // Não é necessario dar o pop
  final Function() onTapAvaliable;
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
                  Text("Essa vaga ficou disponivel para reserva?",
                      textAlign: TextAlign.center, style: TextStyle(fontSize: size.height * .035)),
                  const Divider(),
                  SizedBox(height: size.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonApp(
                          horizontal: EdgeInsets.symmetric(horizontal: size.width * .08),
                          typeOfColorApp: TypeOfColorApp.strong,
                          label: "Sim",
                          onTap: () {
                            Modular.to.pop();
                            onTapAvaliable();
                          }),
                      SizedBox(width: size.width * .04),
                      ButtonApp(
                          horizontal: EdgeInsets.symmetric(horizontal: size.width * .08),
                          typeOfColorApp: TypeOfColorApp.weak,
                          label: "Não",
                          onTap: () {
                            Modular.to.pop();
                          })
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
