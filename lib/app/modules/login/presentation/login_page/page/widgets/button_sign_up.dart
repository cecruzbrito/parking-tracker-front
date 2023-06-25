import 'package:flutter/material.dart';

import '../../../../../../shared/presentation/colors/colors_app.dart';

class ButtonSignUp extends StatelessWidget {
  const ButtonSignUp({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Não possui conta?", style: TextStyle(color: Color.fromRGBO(166, 166, 166, 1))),
        TextButton(onPressed: onTap, child: const Text("Cadastre-se", style: TextStyle(color: ColorsApp.purple)))
      ],
    );
  }
}
