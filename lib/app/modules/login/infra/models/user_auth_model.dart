import 'package:estacionamento_rotativo/app/modules/login/domain/entity/user_auth_entity.dart';

class UserAuthModel extends UserAuthEntity {
  UserAuthModel({required super.idUser, required super.token});

  factory UserAuthModel.fromMap(Map map) => UserAuthModel(idUser: map["id_user"], token: map["token"]);
}
