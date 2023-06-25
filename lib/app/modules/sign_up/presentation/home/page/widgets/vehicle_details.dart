import 'package:estacionamento_rotativo/app/shared/domain/entities/vehicle_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../shared/presentation/colors/colors_app.dart';

class VehicleDetails extends StatelessWidget {
  const VehicleDetails({super.key, required this.vehicle, required this.onTap});
  final VehicleEntity vehicle;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorsApp.purple,
        padding: EdgeInsets.only(left: size.width * .03, right: size.width * .03) +
            EdgeInsets.symmetric(vertical: size.height * .014),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), side: const BorderSide(color: ColorsApp.purple, width: 1)),
        surfaceTintColor: ColorsApp.purple,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(size.height * .006),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorsApp.purple),
                  child: Icon(Icons.directions_car, size: size.height * .04, color: Colors.white),
                ),
                SizedBox(width: size.width * .02),
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Placa: ${vehicle.licensePlate}",
                          maxLines: 1,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black,
                          )),
                      Text("Modelo: ${vehicle.model}",
                          maxLines: 1,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black,
                          )),
                      Text("Cor: ${vehicle.color}",
                          maxLines: 1,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.edit, color: ColorsApp.purple)
        ],
      ),
    );
  }
}
