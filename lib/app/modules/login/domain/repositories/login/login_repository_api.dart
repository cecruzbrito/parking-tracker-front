import 'package:dartz/dartz.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/entities/vehicle_entity.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../../../core/domain/entities/user_entity.dart';
import '../../entity/user_auth_entity.dart';

abstract class LoginApiRepository {
  Future<Either<AppFailure, UserEntity>> login({required String email, required String password});
  Future<Either<AppFailure, UserEntity>> getUser({required UserAuthEntity user});
  Future<Either<AppFailure, VehicleEntity>> getVehicle(
      {required UserAuthEntity user, required ClientUserEntity client});
}
