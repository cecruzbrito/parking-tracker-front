import 'package:estacionamento_rotativo/app/modules/sign_up/domain/entities/user_request_create_entity.dart';

abstract class SingUpDatasource {
  Future<void> singUp(UserRequestCreateEntity request);
}
