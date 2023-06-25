import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingSpaceEntity {
  final int id;
  final StatusParkingSpace status;
  final PositionParkingEntity position;
  final DateTime lastModification;

  ParkingSpaceEntity({
    required this.id,
    required this.status,
    required this.position,
    required this.lastModification,
  });

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
  available,
  reserved,
  assessment,
  pending;

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
      default:
        return StatusParkingSpace.available;
    }
  }

  Future<BitmapDescriptor> getImage() async {
    switch (this) {
      case available:
        return await _setIcon("assets/images/icon_car_avaliable.png");

      case reserved:
        return await _setIcon("assets/images/icon_car_reserved.png");

      case assessment:
        return await _setIcon("assets/images/icon_assessment.png");

      case pending:
        return await _setIcon("assets/images/icon_car_pending.png");
    }
  }

  Future<BitmapDescriptor> _setIcon(String path) async {
    final data = await rootBundle.load(path);
    final codec = await instantiateImageCodec(data.buffer.asUint8List(), targetHeight: 100, targetWidth: 100);
    final fi = await codec.getNextFrame();
    return BitmapDescriptor.fromBytes((await fi.image.toByteData(format: ImageByteFormat.png))!.buffer.asUint8List());
  }
}
