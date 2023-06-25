// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AgentHomePageState {
  final List<Marker> markers;
  final CameraPosition? cameraPosition;

  static AgentHomePageState initState = AgentHomePageState(markers: []);
  AgentHomePageState({
    required this.markers,
    this.cameraPosition,
  });

  AgentHomePageState copyWith({
    List<Marker>? markers,
    CameraPosition? cameraPosition,
  }) {
    return AgentHomePageState(
      markers: markers ?? this.markers,
      cameraPosition: cameraPosition ?? this.cameraPosition,
    );
  }
}
