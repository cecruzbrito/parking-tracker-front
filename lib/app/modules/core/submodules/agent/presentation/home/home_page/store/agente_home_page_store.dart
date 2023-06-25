import 'package:estacionamento_rotativo/app/modules/core/submodules/agent/presentation/home/home_page/state/agent_home_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../page/widgets/bottom_sheet_check_spot.dart';

class AgentHomePageStore extends Store<AgentHomePageState> {
  AgentHomePageStore() : super(AgentHomePageState.initState);

  final keyScaffold = GlobalKey<ScaffoldState>();

  void initializing() {
    _setMarkers();
    _setCameraPosition();
  }

  void _setMarkers() {
    final list = <Marker>[];
    for (var m in [
      const Marker(markerId: MarkerId("1"), position: LatLng(-22.41280397498146, -45.44974965511389)),
      const Marker(markerId: MarkerId("2"), position: LatLng(-22.412494575231158, -45.44999136910507)),
      const Marker(markerId: MarkerId("3"), position: LatLng(-22.41236513111444, -45.44937702169148)),
    ]) {
      list.add(_setOnTapMarker(m));
    }
    update(state.copyWith(markers: list));
  }

  void _setCameraPosition() {
    double sumLat = 0.0;
    double sumLon = 0.0;

    for (final m in state.markers) {
      sumLat += m.position.latitude;
      sumLon += m.position.longitude;
    }

    final latitude = sumLat / state.markers.length;
    final longitude = sumLon / state.markers.length;

    update(state.copyWith(cameraPosition: CameraPosition(target: LatLng(latitude, longitude))));
  }

  Marker _setOnTapMarker(Marker marker) =>
      Marker(markerId: marker.markerId, position: marker.position, onTap: () => _onTapInMarker(marker));

  _onTapInMarker(Marker marker) async => await BottomSheetCheckSpot(
        onTapNegative: () {},
        onTapPositive: () {},
      ).show(keyScaffold.currentContext!);
}
