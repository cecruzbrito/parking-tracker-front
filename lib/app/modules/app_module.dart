import 'package:flutter_modular/flutter_modular.dart';

import 'core/core_module.dart';
import 'login/domain/usecases/social_login/social_auth_usecase_google_auth_imp.dart';
import 'login/external/datasource/google_auth/social_auth_datasource_google.dart';
import 'login/infra/repositories/social_auth_repository/social_auth_repository_imp.dart';
import 'login/login_module.dart';
import 'login/presentation/login_page/page/login_page.dart';
import 'login/presentation/login_page/store/login_page_store.dart';
import 'sign_up/sign_up_module.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => SocialAuthUsecaseGoogleAuthImp(i())),
        Bind((i) => SocialAuthRepositoryImp(i())),
        Bind((i) => SocialAuthDatasourceGoogle()),
        Bind((i) => LoginPageStore(i())),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (context, __) => LoginPage(store: context.read())),
        ModuleRoute("/sign_up", module: SignUpModule()),
        ModuleRoute("/core", module: CoreModule()),
      ];

  @override
  List<Module> get imports => [LoginModule()];
}
