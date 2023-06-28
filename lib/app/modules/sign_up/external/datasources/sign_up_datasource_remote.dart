import 'dart:async';

import 'package:dio/dio.dart';
import 'package:estacionamento_rotativo/app/modules/sign_up/domain/entities/user_request_create_entity.dart';
import 'package:estacionamento_rotativo/app/modules/sign_up/infra/datasources/sing_up_datasource/sing_up_datasource.dart';
import 'package:estacionamento_rotativo/app/modules/sign_up/infra/models/user_request_create_model.dart';

import '../../../../shared/domain/errors/erros.dart';

class SignUpDatasourceRemote implements SingUpDatasource {
  final Dio _dio;

  SignUpDatasourceRemote(this._dio);
  @override
  Future<void> singUp(UserRequestCreateEntity request) async {
    try {
      await _dio
          .post("http://192.168.3.76:8080/auth/register", data: UserRequestCreateModel.toMap(request))
          .timeout(const Duration(seconds: 20));
    } on TimeoutException catch (_) {
      throw const TimeOutFailure("Tempo de requisição excedido");
    } on DioException catch (e) {
      throw GenericFailure(e.message ?? "Erro na requisição");
    } on Exception catch (e) {
      throw GenericFailure("$e");
    }
  }
}
