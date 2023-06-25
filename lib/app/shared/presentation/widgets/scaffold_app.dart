import 'package:flutter/material.dart';
import '../colors/colors_app.dart';
import 'app_bar_default.dart';

class ScaffoldApp extends StatelessWidget {
  const ScaffoldApp(
      {super.key, required this.settingsAppBar, required this.isLoading, required this.body, this.addPadding});
  final AppBarDefault settingsAppBar;
  final EdgeInsets? addPadding;
  final Widget body;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: settingsAppBar.settings.onTapBack == null
            ? null
            : AppBarDefault(
                settings:
                    AppBarSettings(onTapBack: settingsAppBar.settings.onTapBack, title: settingsAppBar.settings.title)),
        body: Stack(
          children: [
            Padding(
                padding: addPadding == null
                    ? EdgeInsets.symmetric(horizontal: size.width * .05)
                    : addPadding! + EdgeInsets.symmetric(horizontal: size.width * .05),
                child: body),
            if (isLoading)
              Container(
                  color: Colors.black.withOpacity(.3),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(color: ColorsApp.purple))
          ],
        ));
  }
}
