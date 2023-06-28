// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'vehicle_view_entity.dart';

class UserRequestCreateEntity {
  final String nome;
  final String email;
  final String senha;
  final String contato;
  final VehicleViewEntity vehicle;
  UserRequestCreateEntity({
    required this.nome,
    required this.email,
    required this.senha,
    required this.contato,
    required this.vehicle,
  });
}
