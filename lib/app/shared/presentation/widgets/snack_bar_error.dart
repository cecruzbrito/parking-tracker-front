import 'package:estacionamento_rotativo/app/shared/presentation/colors/colors_app.dart';
import 'package:flutter/material.dart';

class SnackBarError extends StatelessWidget {
  const SnackBarError({super.key, required this.msgError});
  final String msgError;
  setError(BuildContext ctx) {
    return ScaffoldMessenger.of(ctx)
        .showSnackBar(SnackBar(backgroundColor: ColorsApp.purple, content: this, duration: const Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(msgError, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
