import '../../../../core/domain/entities/user_entity.dart';
import '../../../../core/domain/entities/vehicle_entity.dart';
import '../../../domain/entity/user_auth_entity.dart';

abstract class LoginDatasourceApi {
  Future<UserEntity> login({required String email, required String password});
  Future<UserEntity> getUser({required UserAuthEntity user});
  Future<VehicleEntity> getVehicle({required UserAuthEntity user, required ClientUserEntity client});
}
