import 'package:dartz/dartz.dart';

import 'package:estacionamento_rotativo/app/shared/domain/errors/erros.dart';

import 'package:estacionamento_rotativo/app/modules/login/domain/entity/user_credential_entity.dart';
import 'package:estacionamento_rotativo/app/modules/login/infra/datasources/social_auth_datasource/social_auth_datasource.dart';

import '../../../domain/repositories/social_auth_repository/social_auth_repository.dart';

class SocialAuthRepositoryImp implements SocialAuthRepository {
  final SocialAuthDatasource _datasource;
  SocialAuthRepositoryImp(this._datasource);

  @override
  Future<Either<AppFailure, UserCredentialEntity>> googleAuth() async {
    try {
      return Right(await _datasource.googleAuth());
    } on AppFailure catch (e) {
      return Left(e);
    }
  }
}
