import 'package:dartz/dartz.dart';

import '../../../../../shared/domain/errors/erros.dart';
import '../../entities/parking_space_entity.dart';

abstract class ParkingSpaceGetAllApi {
  Future<Either<AppFailure, List<ParkingSpaceEntity>>> call();
}
