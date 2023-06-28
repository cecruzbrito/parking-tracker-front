import 'package:flutter/material.dart';

import '../../../../../../../../../shared/presentation/colors/colors_app.dart';

class IconNotification extends StatelessWidget {
  const IconNotification({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.only(top: size.height * .05, right: size.width * .01),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(size.height * .01),
              backgroundColor: Colors.white,
              foregroundColor: ColorsApp.purple,
              shape: const CircleBorder()),
          child: Icon(
            Icons.notifications,
            size: size.height * .035,
            color: ColorsApp.purple,
          ),
        ));
  }
}
