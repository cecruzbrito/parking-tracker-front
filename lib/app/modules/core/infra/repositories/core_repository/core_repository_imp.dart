import 'package:estacionamento_rotativo/app/modules/core/domain/entities/user_entity.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/repositories/core_repository/core_repository.dart';

import '../../../../login/domain/entity/user_auth_entity.dart';

class CoreRepositoryImp implements CoreRepository {
  UserAuthEntity? _userAuth;

  @override
  UserAuthEntity? getUserAuth() => _userAuth;

  @override
  UserAuthEntity setUserAuth(UserAuthEntity value) => _userAuth = value;

  UserEntity? _user;

  @override
  UserEntity? getUserEntity() => _user;

  @override
  UserEntity setUserEntity(UserEntity value) => _user = value;
}
