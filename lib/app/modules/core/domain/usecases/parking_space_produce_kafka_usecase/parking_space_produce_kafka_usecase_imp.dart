import 'package:dartz/dartz.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/repositories/parking_space_repository/parking_space_repository.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../entities/parking_space_entity.dart';
import 'parking_space_produce_kafka_usecase.dart';

class ParkingSpaceProduceKafkaUsecaseImp implements ParkingSpaceProduceKafkaUsecase {
  final ParkingSpaceRepository _repository;
  ParkingSpaceProduceKafkaUsecaseImp(this._repository);
  @override
  Future<Either<AppFailure, ParkingSpaceEntity>> call(KafkaSession session, ParkingSpaceEntity ent) async =>
      await _repository.produceStatusVaga(session, ent);
}
