import 'package:estacionamento_rotativo/app/modules/core/domain/entities/parking_space_entity.dart';

abstract class RemoteDataSource {
  Future<List<ParkingSpaceEntity>> getAllParkingSpace();
}
