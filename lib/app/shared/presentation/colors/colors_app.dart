import 'package:flutter/material.dart';

class ColorsApp {
  static const purple = Color.fromARGB(255, 77, 93, 250);
  static const purpleSecundary = Color.fromRGBO(237, 239, 255, 1);
}

enum TypeOfColorApp {
  strong,
  weak;

  Color get color {
    switch (this) {
      case TypeOfColorApp.strong:
        return ColorsApp.purple;
      case TypeOfColorApp.weak:
        return ColorsApp.purpleSecundary;
    }
  }
}
