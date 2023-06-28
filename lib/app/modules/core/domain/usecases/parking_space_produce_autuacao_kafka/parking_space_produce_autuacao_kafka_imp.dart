import 'package:dartz/dartz.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/repositories/parking_space_repository/parking_space_repository.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../shared/domain/errors/erros.dart';
import 'parking_space_produce_autuacao_kafka.dart';

class ParkingSpaceProduceAutuacaoKafkaImp implements ParkingSpaceProduceAutuacaoKafka {
  final ParkingSpaceRepository _repository;
  ParkingSpaceProduceAutuacaoKafkaImp(this._repository);
  @override
  Future<Either<AppFailure, void>> call(KafkaSession session, int idAgente, String placa) async =>
      await _repository.produceAutuacao(session, idAgente, placa);
}
