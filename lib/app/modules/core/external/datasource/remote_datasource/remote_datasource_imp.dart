import 'dart:async';

import 'package:dio/dio.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/repositories/core_repository/core_repository.dart';
import 'package:estacionamento_rotativo/app/modules/core/infra/models/parking_space_model.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../../domain/entities/parking_space_entity.dart';
import '../../../infra/datasources/remote_datasource/remote_datasource.dart';

class RemoteDataSourceImp implements RemoteDataSource {
  final Dio _dio;
  final CoreRepository _repository;

  RemoteDataSourceImp(this._dio, this._repository);
  @override
  Future<List<ParkingSpaceEntity>> getAllParkingSpace() async {
    try {
      final response = await _dio
          .get("http://192.168.3.76:8080/vacancy", options: Options(headers: _repository.getUserAuth()!.authInHeader))
          .timeout(const Duration(seconds: 20));
      return (response.data as List).map((e) => ParkingSpaceModel.fromMap(e)).toList();
    } on TimeoutException catch (_) {
      throw const TimeOutFailure("Tempo de requisição excedido");
    } on DioException catch (e) {
      throw GenericFailure(e.message ?? "Erro na requisição");
    } on Exception catch (e) {
      throw GenericFailure("$e");
    }
  }
}
