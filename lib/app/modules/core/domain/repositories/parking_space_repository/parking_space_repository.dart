import 'package:dartz/dartz.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../entities/parking_space_entity.dart';

abstract class ParkingSpaceRepository {
  Future<Either<AppFailure, Stream<ParkingSpaceEntity>>> consumeKafka(KafkaSession session);
  Future<Either<AppFailure, void>> produce(KafkaSession session, ParkingSpaceEntity parkingEnt);
}
