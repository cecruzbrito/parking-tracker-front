import 'package:dartz/dartz.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/repositories/parking_space_repository/parking_space_repository.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../entities/parking_space_entity.dart';
import 'parking_space_consume_kafka_usecase.dart';

class ParkingSpaceConsumeKafkaUsecaseImp implements ParkingSpaceConsumeKafkaUsecase {
  final ParkingSpaceRepository _repository;
  ParkingSpaceConsumeKafkaUsecaseImp(this._repository);
  @override
  Future<Either<AppFailure, Stream<ParkingSpaceEntity>>> call(KafkaSession session) async =>
      await _repository.consumeKafkaStatusVaga(session);
}
