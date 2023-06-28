import 'package:dartz/dartz.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../../../core/domain/entities/user_entity.dart';

abstract class LoginApiUsecaseAuth {
  Future<Either<AppFailure, UserEntity>> call({required String email, required String password});
}
