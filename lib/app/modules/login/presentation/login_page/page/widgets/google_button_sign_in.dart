import 'package:flutter/material.dart';

class GoogleButtonSignIn extends StatelessWidget {
  const GoogleButtonSignIn({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: size.height * .015),
            backgroundColor: Colors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey, width: .5), borderRadius: BorderRadius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/google_icon.png",
              height: size.height * .03,
            ),
            SizedBox(width: size.width * .03),
            const Text(
              "Continue com Google",
              style: TextStyle(color: Colors.black),
            )
          ],
        ));
  }
}
