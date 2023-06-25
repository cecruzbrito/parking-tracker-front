import 'package:flutter/material.dart';

import '../colors/colors_app.dart';

class ButtonApp extends StatelessWidget {
  const ButtonApp(
      {super.key,
      this.typeOfColorApp = TypeOfColorApp.strong,
      this.horizontal,
      required this.label,
      required this.onTap});
  final String label;
  final Function() onTap;
  final TypeOfColorApp typeOfColorApp;
  final EdgeInsets? horizontal;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: typeOfColorApp.color,
          padding: (horizontal ?? EdgeInsets.zero) + EdgeInsets.symmetric(vertical: size.height * .02),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50)))),
      onPressed: onTap,
      child: Text(label,
          style: TextStyle(color: typeOfColorApp == TypeOfColorApp.strong ? Colors.white : ColorsApp.purple)),
    );
  }
}
