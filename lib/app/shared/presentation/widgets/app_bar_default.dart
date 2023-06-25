// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  final AppBarSettings settings;
  const AppBarDefault({required this.settings, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        title: settings.title == null
            ? null
            : Text(settings.title!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        leading: settings.onTapBack == null
            ? null
            : IconButton(onPressed: settings.onTapBack, icon: const Icon(Icons.arrow_back, color: Colors.black)));
  }
}

class AppBarSettings {
  final String? title;
  final Function()? onTapBack;
  AppBarSettings({
    this.title,
    this.onTapBack,
  });
}
