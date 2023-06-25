import 'dart:convert';

import 'package:estacionamento_rotativo/app/modules/core/domain/entities/parking_space_entity.dart';

class ParkingSpaceModel {
  static Map toMap(ParkingSpaceEntity ent) => {
        "id": ent.id,
        "status": ent.status.toJson(),
        "position": {"lat": ent.position.lat, "log": ent.position.log},
        "last_modification": ent.lastModification.toString()
      };

  static ParkingSpaceEntity fromMap(map) {
    return ParkingSpaceEntity(
        id: map["id"],
        status: StatusParkingSpace.fromMap(map["status"] as int),
        lastModification: DateTime.parse(map["last_modification"]),
        position: PositionParkingModel.fromMap(map["position"]));
  }

  static String toJson(ParkingSpaceEntity ent) => jsonEncode(toMap(ent));

  static ParkingSpaceEntity fromJson(String encoded) => ParkingSpaceModel.fromMap(jsonDecode(encoded));
}

class PositionParkingModel extends PositionParkingEntity {
  PositionParkingModel({required super.lat, required super.log});
  factory PositionParkingModel.fromMap(Map map) => PositionParkingModel(lat: map["lat"], log: map["log"]);
}
