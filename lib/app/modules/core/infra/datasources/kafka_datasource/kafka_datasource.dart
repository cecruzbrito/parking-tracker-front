import 'package:kafkabr/kafka.dart';

import '../../../domain/entities/parking_space_entity.dart';

abstract class KafkaDatasource {
  Future<Stream<ParkingSpaceEntity>> getConsumer(KafkaSession session);
  Future<void> produce(KafkaSession session, ParkingSpaceEntity parkingEnt);
}
