import 'package:dartz/dartz.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../entities/parking_space_entity.dart';
import '../../repositories/parking_space_repository/parking_space_repository.dart';
import 'parkins_space_consume_agente_check_status_usecase.dart';

class ParkingSpaceConsumeAgenteCheckStatusKafkaUsecaseImp implements ParkingSpaceConsumeAgenteCheckStatusKafkaUsecase {
  final ParkingSpaceRepository _repository;

  ParkingSpaceConsumeAgenteCheckStatusKafkaUsecaseImp(this._repository);

  @override
  Future<Either<AppFailure, Stream<ParkingSpaceEntity>>> call(KafkaSession session) async =>
      await _repository.consumeKafkaAgentCheckStatus(session);
}
