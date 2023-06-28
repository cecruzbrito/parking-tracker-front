import 'package:dartz/dartz.dart';
import 'package:estacionamento_rotativo/app/modules/login/domain/repositories/login/login_repository_api.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../../../core/domain/entities/user_entity.dart';
import 'login_api_usecase.dart';

class LoginApiUsecaseAuthImp implements LoginApiUsecaseAuth {
  final LoginApiRepository _repository;
  LoginApiUsecaseAuthImp(this._repository);

  @override
  Future<Either<AppFailure, UserEntity>> call({required String email, required String password}) async =>
      await _repository.login(email: email, password: password);
}
