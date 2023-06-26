import 'package:flutter/material.dart';
import '../colors/colors_app.dart';
import 'app_bar_default.dart';

class ScaffoldApp extends StatefulWidget {
  const ScaffoldApp(
      {super.key, required this.settingsAppBar, required this.isLoading, required this.body, this.addPadding});
  final AppBarDefault settingsAppBar;
  final EdgeInsets? addPadding;
  final Widget body;
  final bool isLoading;

  @override
  State<ScaffoldApp> createState() => _ScaffoldAppState();
}

class _ScaffoldAppState extends State<ScaffoldApp> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: widget.settingsAppBar.settings.onTapBack == null
            ? null
            : AppBarDefault(
                settings: AppBarSettings(
                    onTapBack: widget.settingsAppBar.settings.onTapBack, title: widget.settingsAppBar.settings.title)),
        body: Stack(
          children: [
            Padding(
                padding: widget.addPadding == null
                    ? EdgeInsets.symmetric(horizontal: size.width * .05)
                    : widget.addPadding! + EdgeInsets.symmetric(horizontal: size.width * .05),
                child: widget.body),
            if (widget.isLoading)
              Container(
                  color: Colors.black.withOpacity(.3),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(color: ColorsApp.purple))
          ],
        ));
  }
}
