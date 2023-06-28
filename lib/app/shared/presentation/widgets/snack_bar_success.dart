import 'package:estacionamento_rotativo/app/shared/presentation/colors/colors_app.dart';
import 'package:flutter/material.dart';

class SnackBarSuccess extends StatelessWidget {
  const SnackBarSuccess({super.key, required this.msg});
  final String msg;
  show(BuildContext ctx) => ScaffoldMessenger.of(ctx)
      .showSnackBar(SnackBar(backgroundColor: ColorsApp.purple, content: this, duration: const Duration(seconds: 1)));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(msg, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
