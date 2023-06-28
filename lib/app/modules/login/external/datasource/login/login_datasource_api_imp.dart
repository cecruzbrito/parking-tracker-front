import 'dart:async';

import 'package:dio/dio.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/entities/user_entity.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/entities/vehicle_entity.dart';
import 'package:estacionamento_rotativo/app/modules/core/external/models/user_entity_models.dart';
import 'package:estacionamento_rotativo/app/modules/core/external/models/vehicle_model.dart';
import 'package:estacionamento_rotativo/app/modules/login/domain/entity/user_auth_entity.dart';
import 'package:estacionamento_rotativo/app/modules/login/infra/datasources/login_datasource/login_datasource.dart';
import 'package:estacionamento_rotativo/app/modules/login/infra/models/user_auth_model.dart';
import 'package:estacionamento_rotativo/app/shared/domain/errors/erros.dart';

import '../../../../core/domain/repositories/core_repository/core_repository.dart';
import '../../../domain/entity/errors/login_erros.dart';

class LoginDatasourceApiImp implements LoginDatasourceApi {
  final Dio _dio;
  final CoreRepository _coreRepository;
  LoginDatasourceApiImp(this._dio, this._coreRepository);
  @override
  Future<UserEntity> login({required String email, required String password}) async {
    try {
      final response = await _dio.post("http://192.168.3.76:8080/auth/login",
          data: {"login": email, "password": password}).timeout(const Duration(seconds: 20));

      final userAuth = _coreRepository.setUserAuth(UserAuthModel.fromMap(response.data));
      var user = _coreRepository.setUserEntity(await getUser(user: userAuth));
      if (user.type == TypeOfUser.client) {
        user = _coreRepository.setUserEntity(
            (user as ClientUserEntity).copyWith(vehicle: await getVehicle(client: user, user: userAuth)));
      }
      return user;
    } on TimeoutException catch (_) {
      throw const TimeOutFailure("Tempo de requisição excedido");
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != null) {
        if (e.response!.statusCode == 404) {
          throw UserNotFound(e.response!.data["details"]);
        }
      }
      throw GenericFailure(e.message ?? "Erro na requisição");
    } on Exception catch (e) {
      throw GenericFailure("$e");
    }
  }

  @override
  Future<UserEntity> getUser({required UserAuthEntity user}) async {
    try {
      final response = await _dio
          .get("http://192.168.3.76:8080/user/${user.idUser}", options: Options(headers: user.authInHeader))
          .timeout(const Duration(seconds: 20));

      switch (TypeOfUser.fromMap(response.data["tipoUsuario"])) {
        case TypeOfUser.client:
          return ClientUserModel.fromMap(response.data);

        case TypeOfUser.agent:
          return AgentUserModel.fromMap(response.data);
      }
    } on TimeoutException catch (_) {
      throw const TimeOutFailure("Tempo de requisição excedido");
    } on DioException catch (e) {
      throw GenericFailure(e.message ?? "Erro na requisição");
    } on Exception catch (e) {
      throw GenericFailure("$e");
    }
  }

  @override
  Future<VehicleEntity> getVehicle({required UserAuthEntity user, required ClientUserEntity client}) async {
    try {
      final response = await _dio
          .get("http://192.168.3.76:8080/vehicle/${client.idClient}", options: Options(headers: user.authInHeader))
          .timeout(const Duration(seconds: 20));

      return VehicleModel.from(response.data);
    } on TimeoutException catch (_) {
      throw const TimeOutFailure("Tempo de requisição excedido");
    } on DioException catch (e) {
      throw GenericFailure(e.message ?? "Erro na requisição");
    } on Exception catch (e) {
      throw GenericFailure("$e");
    }
  }
}
