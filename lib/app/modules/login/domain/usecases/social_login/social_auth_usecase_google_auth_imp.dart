import 'package:dartz/dartz.dart';
import 'package:estacionamento_rotativo/app/shared/domain/errors/erros.dart';
import 'package:estacionamento_rotativo/app/modules/login/domain/entity/user_credential_entity.dart';
import 'package:estacionamento_rotativo/app/modules/login/domain/repositories/social_auth_repository/social_auth_repository.dart';
import 'package:estacionamento_rotativo/app/modules/login/domain/usecases/social_login/social_auth_usecase_auth.dart';

class SocialAuthUsecaseGoogleAuthImp implements SocialAuthUsecaseAuth {
  final SocialAuthRepository _repository;

  SocialAuthUsecaseGoogleAuthImp(this._repository);
  @override
  Future<Either<AppFailure, UserCredentialEntity>> call() async => await _repository.googleAuth();
}
