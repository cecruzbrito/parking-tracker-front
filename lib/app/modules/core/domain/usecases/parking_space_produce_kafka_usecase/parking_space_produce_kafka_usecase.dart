import 'package:dartz/dartz.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../entities/parking_space_entity.dart';

abstract class ParkingSpaceProduceKafkaUsecase {
  Future<Either<AppFailure, void>> call(KafkaSession session, ParkingSpaceEntity ent);
}
