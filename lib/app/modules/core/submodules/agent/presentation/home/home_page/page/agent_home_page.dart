import 'package:estacionamento_rotativo/app/modules/core/submodules/agent/presentation/home/home_page/page/widgets/icon_notifications.dart';
import 'package:estacionamento_rotativo/app/modules/core/submodules/agent/presentation/home/home_page/store/agente_home_page_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../../../shared/domain/errors/erros.dart';
import '../../../../../../../../shared/presentation/colors/colors_app.dart';
import '../../../../../../../../shared/presentation/widgets/snack_bar_error.dart';
import '../state/agent_home_page_state.dart';
import 'widgets/navigation_bar_agent.dart';

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
    store.observer(onError: (e) async => await SnackBarError(msgError: (e as AppFailure).message).setError(context));

    super.initState();
    store.initializing();
  }

  @override
  void dispose() {
    super.dispose();
    store.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<AgentHomePageStore, AgentHomePageState>(
        store: store,
        builder: (_, trp) {
          return Scaffold(
              key: store.keyScaffold,
              bottomNavigationBar: NavigatiorBarAgent(
                  currentIndex: trp.state.indexCtrNavigationBar, onTap: store.onTapInIconInNavigation),
              backgroundColor: Colors.white,
              body: trp.isLoading
                  ? Container(
                      color: Colors.black.withOpacity(.3),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(color: ColorsApp.purple))
                  : Stack(
                      children: [
                        GoogleMap(
                            onMapCreated: store.onCreated,
                            mapToolbarEnabled: false,
                            buildingsEnabled: false,
                            tiltGesturesEnabled: false,
                            markers: Set.of(trp.state.markers),
                            minMaxZoomPreference: const MinMaxZoomPreference(19, 50),
                            initialCameraPosition:
                                trp.state.cameraPosition ?? const CameraPosition(target: LatLng(0, 0))),
                        if (trp.state.notifications.isNotEmpty)
                          Align(
                              alignment: Alignment.topRight,
                              child: IconNotification(onTap: store.onTapIconNotifications))
                      ],
                    ));
        });
  }
}
