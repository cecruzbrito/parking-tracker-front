import 'package:dartz/dartz.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../entities/user_request_create_entity.dart';
import '../../repositories/sing_up_repository/sing_up_repository.dart';
import 'sing_up_usecase_sing_up.dart';

class SingUpUsecaseSignUpImp implements SingUpUcaseSignUp {
  final SignUpRepository _repository;

  SingUpUsecaseSignUpImp(this._repository);
  @override
  Future<Either<AppFailure, void>> call(UserRequestCreateEntity request) async => await _repository.singUp(request);
}
