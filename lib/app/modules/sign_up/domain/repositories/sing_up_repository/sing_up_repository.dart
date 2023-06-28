import 'package:dartz/dartz.dart';
import 'package:estacionamento_rotativo/app/modules/sign_up/domain/entities/user_request_create_entity.dart';
import 'package:estacionamento_rotativo/app/shared/domain/errors/erros.dart';

abstract class SignUpRepository {
  Future<Either<AppFailure, void>> singUp(UserRequestCreateEntity request);
}
