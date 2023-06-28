// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:estacionamento_rotativo/app/modules/core/domain/entities/vehicle_entity.dart';

abstract class UserEntity {
  final int id;
  final String nome;
  final String email;
  final String senha;
  final String contato;
  final TypeOfUser type;

  UserEntity({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.contato,
    required this.type,
  });
}

class ClientUserEntity extends UserEntity {
  final int idClient;
  final int creditos;
  final VehicleEntity? vehicle;
  ClientUserEntity({
    required super.id,
    required super.nome,
    required super.email,
    required super.senha,
    required super.contato,
    required super.type,
    required this.idClient,
    required this.creditos,
    this.vehicle,
  });

  ClientUserEntity copyWith(
          {int? idClient,
          int? creditos,
          VehicleEntity? vehicle,
          int? id,
          String? nome,
          String? email,
          String? senha,
          String? contato,
          TypeOfUser? type}) =>
      ClientUserEntity(
        idClient: idClient ?? this.idClient,
        creditos: creditos ?? this.creditos,
        vehicle: vehicle ?? this.vehicle,
        id: id ?? this.id,
        nome: nome ?? this.nome,
        email: email ?? this.email,
        senha: senha ?? this.senha,
        contato: contato ?? this.contato,
        type: type ?? this.type,
      );
}

class AgentUserEntity extends UserEntity {
  final int idAgent;
  final String turno;

  AgentUserEntity(
      {required super.id,
      required super.nome,
      required super.email,
      required super.senha,
      required super.contato,
      required super.type,
      required this.turno,
      required this.idAgent});
}

enum TypeOfUser {
  agent,
  client;

  static TypeOfUser fromMap(String value) {
    switch (value) {
      case "C":
        return TypeOfUser.client;
      default:
        return TypeOfUser.agent;
    }
  }
}
