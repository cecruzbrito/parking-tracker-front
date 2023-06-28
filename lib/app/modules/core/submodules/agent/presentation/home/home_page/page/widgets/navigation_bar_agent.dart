import 'package:estacionamento_rotativo/app/shared/presentation/colors/colors_app.dart';
import 'package:flutter/material.dart';

class NavigatiorBarAgent extends StatelessWidget {
  const NavigatiorBarAgent({super.key, required this.onTap, required this.currentIndex});
  final Function(int) onTap;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.white,
      selectedIndex: currentIndex,
      indicatorColor: const Color.fromARGB(0, 160, 136, 136),
      onDestinationSelected: onTap,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      destinations: const [
        NavigationDestination(
          icon: Icon(
            Icons.home_outlined,
            color: Colors.grey,
          ),
          label: "Home",
          selectedIcon: Icon(
            Icons.home,
            color: ColorsApp.purple,
          ),
        ),
        NavigationDestination(
            icon: Icon(
              Icons.person_outline,
              color: Colors.grey,
            ),
            selectedIcon: Icon(
              Icons.person,
              color: ColorsApp.purple,
            ),
            label: "Perfil")
      ],
    );
  }
}
