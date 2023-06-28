import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../shared/domain/guards/guards_app.dart';
import 'core/core_module.dart';
import 'core/domain/guards/core_guards.dart';
import 'core/infra/repositories/core_repository/core_repository_imp.dart';
import 'login/login_module.dart';
import 'login/presentation/login_page/page/login_page.dart';
import 'sign_up/sign_up_module.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => Dio()),
        Bind.singleton((i) => CoreRepositoryImp()),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (context, __) => LoginPage(store: context.read()), guards: [AppInitiateGuard()]),
        ModuleRoute("/sign_up", module: SignUpModule()),
        ModuleRoute("/core", module: CoreModule(), guards: [UserAuthGuard()]),
      ];

  @override
  List<Module> get imports => [LoginModule()];
}
