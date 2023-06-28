import 'package:estacionamento_rotativo/app/modules/core/domain/entities/user_entity.dart';

import '../../../../login/domain/entity/user_auth_entity.dart';

abstract class CoreRepository {
  UserAuthEntity? getUserAuth();
  UserAuthEntity setUserAuth(UserAuthEntity value);
  UserEntity? getUserEntity();
  UserEntity setUserEntity(UserEntity value);
}
