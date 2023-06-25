import 'package:dartz/dartz.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../entity/user_credential_entity.dart';

abstract class SocialAuthUsecaseAuth {
  Future<Either<AppFailure, UserCredentialEntity>> call();
}
