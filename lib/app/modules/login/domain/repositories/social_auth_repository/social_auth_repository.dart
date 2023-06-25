import 'package:dartz/dartz.dart';
import '../../../../../shared/domain/errors/erros.dart';
import '../../entity/user_credential_entity.dart';

abstract class SocialAuthRepository {
  Future<Either<AppFailure, UserCredentialEntity>> googleAuth();
}
