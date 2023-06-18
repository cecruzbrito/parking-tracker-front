import 'package:flutter_modular/flutter_modular.dart';

import 'home/home_module.dart';
import 'shared/submodules/app_splash/presentation/app_splash_page.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes =>
      [ChildRoute("/", child: (_, __) => const AppSplashPage()), ModuleRoute("/home", module: HomeModule())];
}
