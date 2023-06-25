import 'package:flutter_modular/flutter_modular.dart';

import 'core/core_module.dart';
import 'login/login_module.dart';
import 'login/presentation/login_page/page/login_page.dart';
import 'sign_up/sign_up_module.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (context, __) => LoginPage(store: context.read())),
        ModuleRoute("/sign_up", module: SignUpModule()),
        ModuleRoute("/core", module: CoreModule()),
      ];

  @override
  List<Module> get imports => [LoginModule()];
}
