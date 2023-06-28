import 'package:dartz/dartz.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/entities/user_entity.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/entities/vehicle_entity.dart';
import 'package:estacionamento_rotativo/app/modules/login/domain/entity/user_auth_entity.dart';
import 'package:estacionamento_rotativo/app/modules/login/domain/repositories/login/login_repository_api.dart';
import 'package:estacionamento_rotativo/app/shared/domain/errors/erros.dart';

import '../../datasources/login_datasource/login_datasource.dart';

class LoginApiRepositoryImp extends LoginApiRepository {
  final LoginDatasourceApi _loginDatasourceApi;
  LoginApiRepositoryImp(this._loginDatasourceApi);
  @override
  Future<Either<AppFailure, UserEntity>> login({required String email, required String password}) async {
    try {
      return Right(await _loginDatasourceApi.login(email: email, password: password));
    } on AppFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppFailure, UserEntity>> getUser({required UserAuthEntity user}) async {
    try {
      return Right(await _loginDatasourceApi.getUser(user: user));
    } on AppFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppFailure, VehicleEntity>> getVehicle(
      {required UserAuthEntity user, required ClientUserEntity client}) async {
    try {
      return Right(await _loginDatasourceApi.getVehicle(user: user, client: client));
    } on AppFailure catch (e) {
      return Left(e);
    }
  }
}
