import 'dart:convert';

import 'package:estacionamento_rotativo/app/modules/core/domain/entities/parking_space_entity.dart';
import 'package:intl/intl.dart';

import '../../external/models/vehicle_model.dart';

class ParkingSpaceModel {
  static Map toMap(ParkingSpaceEntity ent) {
    Map<String, dynamic> response = {
      "id_vaga": ent.id,
      "status": ent.status.toJson(),
      "lat": ent.position.lat,
      "longi": ent.position.log,
      "lastModification": _dateToString(ent.lastModification),
      if (ent.reservation != null) "reservation": _dateToString(ent.reservation!)
    };

    if (ent.vehicle != null) {
      response["veiculo"] = (ent.vehicle as VehicleModel).toMap();
    }

    return response;
  }

  static ParkingSpaceEntity fromMap(Map<String, dynamic> map) => ParkingSpaceEntity(
      vehicle: map["veiculo"] == null ? null : VehicleModel.from(map['veiculo']),
      id: map["id_vaga"],
      status: StatusParkingSpace.fromMap(map["status"] as int),
      lastModification: _parseStringToDate(map["lastModification"]),
      position: PositionParkingModel.fromMap(map),
      reservation: map["reservation"] == null ? null : _parseStringToDate(map["reservation"]));

  static String _dateToString(DateTime time) => DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(time);

  static DateTime _parseStringToDate(String time) => DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(time);

  static String toJson(ParkingSpaceEntity ent) => jsonEncode(toMap(ent));

  static ParkingSpaceEntity fromJson(String encoded) => ParkingSpaceModel.fromMap(jsonDecode(encoded));
}

class PositionParkingModel extends PositionParkingEntity {
  PositionParkingModel({required super.lat, required super.log});
  factory PositionParkingModel.fromMap(Map map) => PositionParkingModel(lat: map["lat"], log: map["longi"]);
}
