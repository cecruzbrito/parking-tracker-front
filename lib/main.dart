import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/modules/app_module.dart';

void main() => runApp(ModularApp(module: AppModule(), child: const App()));

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      );
}
