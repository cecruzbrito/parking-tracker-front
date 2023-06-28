import 'package:dartz/dartz.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/repositories/parking_space_repository/parking_space_repository.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../entities/parking_space_entity.dart';
import 'parking_space_get_all_api.dart';

class ParkingSpaceGetAllApiImp extends ParkingSpaceGetAllApi {
  final ParkingSpaceRepository _repository;

  ParkingSpaceGetAllApiImp(this._repository);
  @override
  Future<Either<AppFailure, List<ParkingSpaceEntity>>> call() async => await _repository.getAllParkingSpace();
}
