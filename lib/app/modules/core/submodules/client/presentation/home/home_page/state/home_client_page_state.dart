// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../domain/entities/parking_space_entity.dart';

class HomeClientPageState {
  static HomeClientPageState initState = HomeClientPageState(indexCtrNavigationBar: 0, markers: [], parking: []);

  final int indexCtrNavigationBar;
  final List<Marker> markers;
  final List<ParkingSpaceEntity> parking;
  final CameraPosition? cameraPosition;
  final ParkingSpaceEntity? parkingSpaceSelectedUser;
  HomeClientPageState(
      {required this.indexCtrNavigationBar,
      this.parkingSpaceSelectedUser,
      required this.markers,
      this.cameraPosition,
      required this.parking});

  HomeClientPageState copyWith({
    int? indexCtrNavigationBar,
    List<Marker>? markers,
    List<ParkingSpaceEntity>? parking,
    CameraPosition? cameraPosition,
    ParkingSpaceEntity? parkingSpaceSelectedUser,
  }) {
    return HomeClientPageState(
      indexCtrNavigationBar: indexCtrNavigationBar ?? this.indexCtrNavigationBar,
      markers: markers ?? this.markers,
      parking: parking ?? this.parking,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      parkingSpaceSelectedUser: parkingSpaceSelectedUser ?? this.parkingSpaceSelectedUser,
    );
  }

  HomeClientPageState resetSelectedParkingSpace({
    ParkingSpaceEntity? parkingSpaceSelectedUser,
  }) {
    return HomeClientPageState(
        indexCtrNavigationBar: indexCtrNavigationBar,
        markers: markers,
        parking: parking,
        cameraPosition: cameraPosition,
        parkingSpaceSelectedUser: parkingSpaceSelectedUser);
  }
}
