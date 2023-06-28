// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:estacionamento_rotativo/app/shared/presentation/colors/colors_app.dart';
import 'package:flutter/services.dart';

class FieldApp extends StatelessWidget {
  const FieldApp({super.key, required this.settings});
  final SettingsFieldApp settings;
  @override
  Widget build(BuildContext context) {
    const colorGreyPrimary = Color.fromARGB(255, 250, 250, 250);

    var border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10.0),
    );
    var focused = OutlineInputBorder(
      borderSide: const BorderSide(color: ColorsApp.purple),
      borderRadius: BorderRadius.circular(10.0),
    );
    var errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(10.0),
    );
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: ColorsApp.purple),
      child: TextFormField(
          keyboardType: settings.inputType,
          inputFormatters: settings.formatters,
          controller: settings.ctr,
          validator: settings.validator,
          obscureText: settings.hasShowText == null ? false : !settings.hasShowText!,
          decoration: InputDecoration(
              hoverColor: Colors.red,
              fillColor: colorGreyPrimary,
              filled: true,
              labelText: settings.labelText,
              prefixIcon: settings.prefixIcon != null ? Icon(settings.prefixIcon) : null,
              suffixIcon: settings.suffixIcon == null
                  ? null
                  : IconButton(onPressed: settings.suffixIcon!.onTap, icon: Icon(settings.suffixIcon!.icon)),
              border: border,
              errorBorder: errorBorder,
              focusedBorder: focused,
              enabledBorder: border)),
    );
  }
}

class SettingsFieldApp {
  final TextEditingController ctr;
  final IconData? prefixIcon;
  final String? labelText;
  final SufixIconFieldApp? suffixIcon;
  final bool? hasShowText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatters;
  final TextInputType? inputType;
  SettingsFieldApp(
      {required this.ctr,
      this.formatters,
      this.inputType,
      this.validator,
      this.prefixIcon,
      this.labelText,
      this.suffixIcon,
      this.hasShowText});
}

class SufixIconFieldApp {
  final IconData icon;
  final Function() onTap;
  SufixIconFieldApp({required this.icon, required this.onTap});
}
