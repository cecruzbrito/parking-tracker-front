import 'package:estacionamento_rotativo/app/modules/core/submodules/agent/presentation/home/home_page/store/agente_home_page_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../state/agent_home_page_state.dart';

class AgentHomePage extends StatefulWidget {
  const AgentHomePage({super.key, required this.store});
  final AgentHomePageStore store;
  @override
  State<AgentHomePage> createState() => _AgentHomePageState();
}

class _AgentHomePageState extends State<AgentHomePage> {
  AgentHomePageStore get store => widget.store;

  @override
  void initState() {
    super.initState();
    store.initializing();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<AgentHomePageStore, AgentHomePageState>(
        store: store,
        builder: (_, trp) {
          return Scaffold(
            key: store.keyScaffold,
            backgroundColor: Colors.white,
            body: GoogleMap(
                mapToolbarEnabled: false,
                buildingsEnabled: false,
                tiltGesturesEnabled: false,
                markers: Set.of(trp.state.markers),
                minMaxZoomPreference: const MinMaxZoomPreference(19, 50),
                initialCameraPosition: trp.state.cameraPosition ?? const CameraPosition(target: LatLng(0, 0))),
          );
        });
  }
}
