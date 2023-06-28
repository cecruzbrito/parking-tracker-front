import 'package:flutter/material.dart';

class ColorsApp {
  static const purple = Color.fromARGB(255, 77, 93, 250);
  static const purpleSecundary = Color.fromRGBO(237, 239, 255, 1);
}

enum TypeOfColorApp {
  strong,
  weak,
  error;

  Color get color {
    switch (this) {
      case TypeOfColorApp.strong:
        return ColorsApp.purple;
      case TypeOfColorApp.weak:
        return ColorsApp.purpleSecundary;
      case TypeOfColorApp.error:
        return Colors.red;
    }
  }

  Color get colorFont {
    switch (this) {
      case TypeOfColorApp.strong:
        return Colors.white;
      case TypeOfColorApp.weak:
        return ColorsApp.purple;
      case TypeOfColorApp.error:
        return Colors.white;
    }
  }
}
