import 'package:dartz/dartz.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../entities/user_request_create_entity.dart';

abstract class SingUpUcaseSignUp {
  Future<Either<AppFailure, void>> call(UserRequestCreateEntity request);
}
