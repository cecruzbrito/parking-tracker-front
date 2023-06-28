import 'package:kafkabr/kafka.dart';

import '../../../domain/entities/parking_space_entity.dart';

abstract class KafkaDatasource {
  Future<Stream<ParkingSpaceEntity>> getConsumerStatusVaga(KafkaSession session);
  Future<Stream<ParkingSpaceEntity>> consumeKafkaAgentCheckStatus(KafkaSession session);
  Future<ParkingSpaceEntity> produce(KafkaSession session, ParkingSpaceEntity parkingEnt);
  Future<void> produceAutuacao(KafkaSession session, int idAgente, String placa);
}
