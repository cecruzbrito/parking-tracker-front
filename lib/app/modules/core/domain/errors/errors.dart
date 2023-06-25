import 'package:estacionamento_rotativo/app/shared/domain/errors/erros.dart';

class KafkaConsumerError implements AppFailure {
  final String _message;
  KafkaConsumerError(this._message);

  @override
  String get message => _message;
}

class KafkaProducerError implements AppFailure {
  final String _message;
  KafkaProducerError(this._message);

  @override
  String get message => _message;
}
