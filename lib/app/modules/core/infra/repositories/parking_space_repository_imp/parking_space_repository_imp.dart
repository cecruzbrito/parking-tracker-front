import 'package:dartz/dartz.dart';
import 'package:estacionamento_rotativo/app/modules/core/infra/datasources/remote_datasource/remote_datasource.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../../domain/entities/parking_space_entity.dart';
import '../../../domain/repositories/parking_space_repository/parking_space_repository.dart';
import '../../datasources/kafka_datasource/kafka_datasource.dart';

class ParkingSpaceRepositoryImp implements ParkingSpaceRepository {
  final KafkaDatasource _datasource;
  final RemoteDataSource _remoteDataSource;
  ParkingSpaceRepositoryImp(this._datasource, this._remoteDataSource);
  @override
  Future<Either<AppFailure, Stream<ParkingSpaceEntity>>> consumeKafkaStatusVaga(KafkaSession session) async {
    try {
      return Right(await _datasource.getConsumerStatusVaga(session));
    } on AppFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppFailure, ParkingSpaceEntity>> produceStatusVaga(
      KafkaSession session, ParkingSpaceEntity parkingEnt) async {
    try {
      return Right(await _datasource.produce(session, parkingEnt));
    } on AppFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppFailure, List<ParkingSpaceEntity>>> getAllParkingSpace() async {
    try {
      return Right(await _remoteDataSource.getAllParkingSpace());
    } on AppFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppFailure, Stream<ParkingSpaceEntity>>> consumeKafkaAgentCheckStatus(KafkaSession session) async {
    try {
      return Right(await _datasource.consumeKafkaAgentCheckStatus(session));
    } on AppFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppFailure, void>> produceAutuacao(KafkaSession session, int idAgente, String placa) async {
    try {
      // ignore: void_checks
      return Right(await _datasource.produceAutuacao(session, idAgente, placa));
    } on AppFailure catch (e) {
      return Left(e);
    }
  }
}
