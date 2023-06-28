import 'package:dartz/dartz.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../shared/domain/errors/erros.dart';

abstract class ParkingSpaceProduceAutuacaoKafka {
  Future<Either<AppFailure, void>> call(KafkaSession session, int idAgente, String placa);
}
