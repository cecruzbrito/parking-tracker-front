import 'dart:ui';

import 'package:estacionamento_rotativo/app/modules/core/domain/entities/vehicle_entity.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingSpaceEntity {
  final int id;
  final VehicleEntity? vehicle;
  final StatusParkingSpace status;
  final PositionParkingEntity position;
  final DateTime lastModification;
  final DateTime? reservation;

  ParkingSpaceEntity({
    required this.id,
    required this.status,
    required this.position,
    required this.lastModification,
    this.vehicle,
    this.reservation,
  });

  bool get isExpired => reservation == null
      ? false
      : reservation!.isBefore(DateTime.now()) || reservation!.isAtSameMomentAs(DateTime.now());

  @override
  String toString() {
    return "id: $id\nstatus: $status\nposition: $position\n lastMod:$lastModification";
  }
}

class PositionParkingEntity {
  final double lat;
  final double log;
  PositionParkingEntity({required this.lat, required this.log});

  @override
  String toString() => "Position(lat: $lat, log: $log)";
}

enum StatusParkingSpace {
  available, //disponivel
  reserved, //reservada
  assessment, //autuada
  pending, //pendente (geral)
  pendingExit, //checar_pendencia_saida
  pendingArrival; //checar_pendencia_gerada

  int toJson() {
    switch (this) {
      case available:
        return 0;

      case reserved:
        return 1;

      case assessment:
        return 2;

      case pending:
        return 3;

      case pendingExit:
        return 4;

      case pendingArrival:
        return 5;
    }
  }

  static StatusParkingSpace fromMap(int code) {
    switch (code) {
      case 0:
        return StatusParkingSpace.available;
      case 1:
        return StatusParkingSpace.reserved;
      case 2:
        return StatusParkingSpace.assessment;
      case 3:
        return StatusParkingSpace.pending;
      case 4:
        return StatusParkingSpace.pendingExit;
      case 5:
        return StatusParkingSpace.pendingArrival;
      default:
        return StatusParkingSpace.available;
    }
  }

  Future<BitmapDescriptor> getImage() async {
    switch (this) {
      case available:
        return await _setIcon("assets/images/available.png");

      case reserved:
        return await _setIcon("assets/images/reserved.png");

      case assessment:
        return await _setIcon("assets/images/icon_assessment.png");

      case pending:
        return await _setIcon("assets/images/warning.png");

      default:
        return await _setIcon("assets/images/warning.png");
    }
  }

  Future<BitmapDescriptor> _setIcon(String path) async {
    final data = await rootBundle.load(path);
    final codec = await instantiateImageCodec(data.buffer.asUint8List(), targetHeight: 70, targetWidth: 70);
    final fi = await codec.getNextFrame();
    return BitmapDescriptor.fromBytes((await fi.image.toByteData(format: ImageByteFormat.png))!.buffer.asUint8List());
  }
}
