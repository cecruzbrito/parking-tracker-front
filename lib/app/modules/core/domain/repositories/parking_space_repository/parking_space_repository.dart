import 'package:dartz/dartz.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../entities/parking_space_entity.dart';

abstract class ParkingSpaceRepository {
  Future<Either<AppFailure, Stream<ParkingSpaceEntity>>> consumeKafkaStatusVaga(KafkaSession session);
  Future<Either<AppFailure, ParkingSpaceEntity>> produceStatusVaga(KafkaSession session, ParkingSpaceEntity parkingEnt);
  Future<Either<AppFailure, void>> produceAutuacao(KafkaSession session, int idAgente, String placa);
  Future<Either<AppFailure, List<ParkingSpaceEntity>>> getAllParkingSpace();
  Future<Either<AppFailure, Stream<ParkingSpaceEntity>>> consumeKafkaAgentCheckStatus(KafkaSession session);
}
