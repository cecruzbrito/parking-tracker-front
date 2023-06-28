import 'package:estacionamento_rotativo/app/modules/sign_up/domain/entities/user_request_create_entity.dart';
import 'package:estacionamento_rotativo/app/modules/sign_up/infra/models/vehicle_view_model.dart';

class UserRequestCreateModel {
  static Map toMap(UserRequestCreateEntity request) {
    final response = {
      "nome": request.nome,
      "email": request.email,
      "senha": request.senha,
      "contato": request.contato,
      "tipoUsuario": "C",
      "turno": null,
      "creditos": 0,
    };

    response.addAll(VehicleViewModel.toMap(request.vehicle));

    return response;
  }
}
