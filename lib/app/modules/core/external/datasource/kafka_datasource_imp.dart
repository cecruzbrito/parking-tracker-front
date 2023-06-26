import 'dart:math';

import 'package:estacionamento_rotativo/app/modules/core/domain/entities/parking_space_entity.dart';
import 'package:estacionamento_rotativo/app/modules/core/infra/models/parking_space_model.dart';
import 'package:kafkabr/kafka.dart';

import '../../domain/errors/errors.dart';
import '../../infra/datasources/kafka_datasource/kafka_datasource.dart';

class KafkaDatasourceImp implements KafkaDatasource {
  @override
  Future<Stream<ParkingSpaceEntity>> getConsumer(KafkaSession session) async {
    try {
      var topicPartitions = {
        "STATUS_VAGA": {0}
      };
      final consumer =
          Consumer(session, ConsumerGroup(session, "Vaga${Random().nextInt(1000)}"), topicPartitions, 100, 1);

      return consumer.consume().asyncMap<ParkingSpaceEntity>((event) {
        final park = ParkingSpaceModel.fromJson(String.fromCharCodes(event.message.value));
        event.ack();
        return park;
      });
    } on FormatException catch (e) {
      throw KafkaConsumerError(e.message);
    } on MessageCrcMismatchError catch (e) {
      throw KafkaConsumerError(e.message);
    } on Exception catch (e) {
      throw KafkaConsumerError("$e");
    }
  }

  @override
  Future<ParkingSpaceEntity> produce(KafkaSession session, ParkingSpaceEntity ent) async {
    try {
      var producer = Producer(session, 1, 1000);
      await producer.produce([
        ProduceEnvelope('STATUS_VAGA', 0,
            [Message(ParkingSpaceModel.toJson(ent).codeUnits, key: "${Random().nextInt(500000)}".codeUnits)]),
      ]);
      return ent;
    } on FormatException catch (e) {
      throw KafkaProducerError(e.message);
    } on ProduceError catch (e) {
      throw KafkaProducerError(e.result.errors.map((e) => e.message).join(","));
    } on Exception catch (e) {
      throw KafkaProducerError("$e");
    }
  }
}
