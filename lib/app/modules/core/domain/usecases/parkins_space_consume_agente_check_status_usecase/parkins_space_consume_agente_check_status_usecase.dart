import 'package:dartz/dartz.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../entities/parking_space_entity.dart';

abstract class ParkingSpaceConsumeAgenteCheckStatusKafkaUsecase {
  Future<Either<AppFailure, Stream<ParkingSpaceEntity>>> call(KafkaSession session);
}
