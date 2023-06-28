import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../../shared/presentation/colors/colors_app.dart';
import '../../../../../../../domain/entities/parking_space_entity.dart';

class BottomSheetSeeNotification extends StatelessWidget {
  const BottomSheetSeeNotification({super.key, required this.parks, required this.onTapSeeVagas});
  final Function(ParkingSpaceEntity) onTapSeeVagas;
  final List<ParkingSpaceEntity> parks;

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
              margin: EdgeInsets.symmetric(vertical: size.height * .03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Notificações", textAlign: TextAlign.center, style: TextStyle(fontSize: size.height * .035)),
                  const Divider(),
                  SizedBox(height: size.height * .02),
                  SizedBox(
                    height: size.height * .3,
                    child: SingleChildScrollView(
                      child: Column(
                          children: parks
                              .map((e) => IconList(park: e, onTapSeeVagas: onTapSeeVagas))
                              .toList()
                              .expand((e) => [e, const Divider()])
                              .toList()),
                    ),
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

class IconList extends StatelessWidget {
  const IconList({super.key, required this.onTapSeeVagas, required this.park});
  final Function(ParkingSpaceEntity) onTapSeeVagas;
  final ParkingSpaceEntity park;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String text = "";
    switch (park.status) {
      case StatusParkingSpace.pendingArrival:
        text = "Status: Checar se o veiculo chegou";
        break;

      case StatusParkingSpace.pendingExit:
        text = "Status: Checar se o veiculo se retirou";
        break;
      default:
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: ColorsApp.purple,
                    size: size.height * .025,
                  ),
                  SizedBox(width: size.width * .02),
                  Flexible(
                    child: Text(
                        "Data da reserva: ${DateFormat('dd/MM/yy - HH:mm:ss').format(park.reservation!.subtract(const Duration(hours: 1)))}"),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: ColorsApp.purple,
                    size: size.height * .025,
                  ),
                  SizedBox(width: size.width * .02),
                  Flexible(
                      child: Text(
                          "Data do fim da reserva: ${DateFormat('dd/MM/yy - HH:mm:ss').format(park.reservation!)}")),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.directions_car,
                    color: ColorsApp.purple,
                    size: size.height * .025,
                  ),
                  SizedBox(width: size.width * .02),
                  Flexible(child: Text("Placa do véiculo: ${park.vehicle!.licensePlate}")),
                ],
              ),
              Row(children: [
                Icon(
                  Icons.check,
                  color: ColorsApp.purple,
                  size: size.height * .025,
                ),
                SizedBox(width: size.width * .02),
                Flexible(child: Text(text)),
              ])
            ].expand((e) => [e, SizedBox(height: size.height * .01)]).toList(),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Modular.to.pop();
            onTapSeeVagas(park);
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(size.height * .01),
              backgroundColor: ColorsApp.purple,
              foregroundColor: Colors.white,
              shape: const CircleBorder()),
          child: Icon(
            Icons.location_on,
            size: size.height * .035,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
