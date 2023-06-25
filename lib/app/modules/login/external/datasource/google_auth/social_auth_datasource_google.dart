import 'package:estacionamento_rotativo/app/shared/domain/errors/erros.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../domain/entity/errors/social_auth_errors.dart';
import '../../../infra/datasources/social_auth_datasource/social_auth_datasource.dart';
import '../../../infra/models/user_credencial_model.dart';

class SocialAuthDatasourceGoogle implements SocialAuthDatasource {
  @override
  Future<UserCredentialModel> googleAuth() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) throw SocialAuthCanceled();

      await GoogleSignIn().disconnect();

      return UserCredentialModel.fromGoogleAuth(googleUser);
    } on PlatformException catch (e) {
      throw DomainFailure(e.message ?? "Erro desconhecido");
    } on AppFailure {
      rethrow;
    } on Exception catch (e) {
      throw GenericFailure("$e");
    }
  }
}
