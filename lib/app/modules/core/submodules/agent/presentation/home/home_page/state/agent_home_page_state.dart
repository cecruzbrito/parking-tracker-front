// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../domain/entities/parking_space_entity.dart';

class AgentHomePageState {
  final List<Marker> markers;
  final CameraPosition? cameraPosition;
  final List<ParkingSpaceEntity> parking;
  final List<ParkingSpaceEntity> notifications;
  final int indexCtrNavigationBar;

  static AgentHomePageState initState =
      AgentHomePageState(markers: [], parking: [], indexCtrNavigationBar: 0, notifications: []);
  AgentHomePageState(
      {required this.markers,
      this.cameraPosition,
      required this.parking,
      required this.indexCtrNavigationBar,
      required this.notifications});

  AgentHomePageState copyWith({
    List<Marker>? markers,
    CameraPosition? cameraPosition,
    List<ParkingSpaceEntity>? parking,
    List<ParkingSpaceEntity>? notifications,
    int? indexCtrNavigationBar,
  }) =>
      AgentHomePageState(
        markers: markers ?? this.markers,
        cameraPosition: cameraPosition ?? this.cameraPosition,
        parking: parking ?? this.parking,
        notifications: notifications ?? this.notifications,
        indexCtrNavigationBar: indexCtrNavigationBar ?? this.indexCtrNavigationBar,
      );
}
