import 'package:estacionamento_rotativo/app/modules/login/infra/models/user_credencial_model.dart';

abstract class SocialAuthDatasource {
  Future<UserCredentialModel> googleAuth();
}
