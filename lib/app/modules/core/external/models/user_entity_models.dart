import '../../domain/entities/user_entity.dart';

class ClientUserModel extends ClientUserEntity {
  ClientUserModel(
      {required super.id,
      required super.nome,
      required super.email,
      required super.senha,
      required super.contato,
      required super.type,
      required super.idClient,
      required super.creditos});

  factory ClientUserModel.fromMap(Map map) => ClientUserModel(
      idClient: map["idChild"],
      contato: map["contato"],
      creditos: map["creditos"],
      email: map["email"],
      id: map["idUser"],
      nome: map["nome"],
      senha: map["senha"],
      type: TypeOfUser.client);
}

class AgentUserModel extends AgentUserEntity {
  AgentUserModel(
      {required super.id,
      required super.nome,
      required super.email,
      required super.senha,
      required super.contato,
      required super.type,
      required super.turno,
      required super.idAgent});

  factory AgentUserModel.fromMap(Map map) => AgentUserModel(
      idAgent: map["idChild"],
      contato: map["contato"],
      email: map["email"],
      id: map["idUser"],
      nome: map["nome"],
      senha: map["senha"],
      turno: map["turno"],
      type: TypeOfUser.agent);
}
