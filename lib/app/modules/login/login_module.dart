import 'package:estacionamento_rotativo/app/modules/login/domain/usecases/login/login_api_usecase_imp.dart';
import 'package:estacionamento_rotativo/app/modules/login/external/datasource/login/login_datasource_api_imp.dart';
import 'package:estacionamento_rotativo/app/modules/login/infra/repositories/login_api_repository/login_api_repository_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/social_login/social_auth_usecase_google_auth_imp.dart';
import 'external/datasource/google_auth/social_auth_datasource_google.dart';
import 'infra/repositories/social_auth_repository/social_auth_repository_imp.dart';
import 'presentation/login_page/store/login_page_store.dart';

class LoginModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => SocialAuthUsecaseGoogleAuthImp(i()), export: true),
        Bind((i) => SocialAuthRepositoryImp(i()), export: true),
        Bind((i) => SocialAuthDatasourceGoogle(), export: true),
        Bind((i) => LoginPageStore(i(), i()), export: true),
        Bind((i) => LoginApiUsecaseAuthImp(i()), export: true),
        Bind((i) => LoginApiRepositoryImp(i()), export: true),
        Bind((i) => LoginDatasourceApiImp(i(), i()), export: true),
      ];
}
