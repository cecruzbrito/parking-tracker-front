import 'package:dartz/dartz.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../../domain/entities/parking_space_entity.dart';
import '../../../domain/repositories/parking_space_repository/parking_space_repository.dart';
import '../../datasources/kafka_datasource/kafka_datasource.dart';

class ParkingSpaceRepositoryImp implements ParkingSpaceRepository {
  final KafkaDatasource _datasource;
  ParkingSpaceRepositoryImp(this._datasource);
  @override
  Future<Either<AppFailure, Stream<ParkingSpaceEntity>>> consumeKafka(KafkaSession session) async {
    try {
      return Right(await _datasource.getConsumer(session));
    } on AppFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppFailure, ParkingSpaceEntity>> produce(KafkaSession session, ParkingSpaceEntity parkingEnt) async {
    try {
      return Right(await _datasource.produce(session, parkingEnt));
    } on AppFailure catch (e) {
      return Left(e);
    }
  }
}
