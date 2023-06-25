import 'package:estacionamento_rotativo/app/modules/core/domain/usecases/parking_space_consume_kafka_usecase/parking_space_consume_kafka_usecase_imp.dart';
import 'package:estacionamento_rotativo/app/modules/core/external/datasource/kafka_datasource_imp.dart';
import 'package:estacionamento_rotativo/app/modules/core/infra/repositories/parking_space_repository_imp/parking_space_repository_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/parking_space_produce_kafka_usecase/parking_space_produce_kafka_usecase_imp.dart';
import 'submodules/agent/agent_module.dart';
import 'submodules/client/client_module.dart';

class CoreModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => ParkingSpaceRepositoryImp(i())),
        Bind((i) => KafkaDatasourceImp()),
        Bind((i) => ParkingSpaceConsumeKafkaUsecaseImp(i())),
        Bind((i) => ParkingSpaceProduceKafkaUsecaseImp(i())),
      ];
  @override
  List<ModularRoute> get routes => [
        ModuleRoute("/client", module: ClientModule()),
        ModuleRoute("/agent", module: AgentModule()),
      ];
}
