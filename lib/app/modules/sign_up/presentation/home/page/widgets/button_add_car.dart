import 'package:flutter/material.dart';

import '../../../../../../shared/presentation/colors/colors_app.dart';

class ButtonAddCar extends StatelessWidget {
  const ButtonAddCar({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: size.height * .015),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), side: const BorderSide(color: ColorsApp.purple, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: size.width * .05, right: size.width * .03),
            padding: EdgeInsets.all(size.height * .005),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsApp.purple,
            ),
            child: Icon(
              Icons.add,
              size: size.height * .04,
              color: Colors.white,
            ),
          ),
          const Text(
            "Adicione um veiculo",
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
