import 'package:estacionamento_rotativo/app/modules/core/submodules/client/presentation/home/home_page/page/widgets/icon_see_parking_spaces_reserved.dart';
import 'package:estacionamento_rotativo/app/modules/core/submodules/client/presentation/home/home_page/state/home_client_page_state.dart';
import 'package:estacionamento_rotativo/app/shared/domain/errors/erros.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../../../shared/presentation/widgets/snack_bar_error.dart';
import '../store/home_client_page_store.dart';
import 'widgets/navigation_bar_client.dart';

class HomeClientPage extends StatefulWidget {
  const HomeClientPage({super.key, required this.store});
  final HomeClientPageStore store;
  @override
  State<HomeClientPage> createState() => _HomeClientPageState();
}

class _HomeClientPageState extends State<HomeClientPage> {
  HomeClientPageStore get store => widget.store;

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
    return TripleBuilder<HomeClientPageStore, HomeClientPageState>(
        store: store,
        key: UniqueKey(),
        builder: (_, trp) {
          return Scaffold(
              key: store.keyScaffold,
              backgroundColor: Colors.white,
              bottomNavigationBar: NavigatiorBarClient(
                currentIndex: trp.state.indexCtrNavigationBar,
                onTap: store.onTapInIconInNavigation,
              ),
              body: Stack(
                children: [
                  GoogleMap(
                      onMapCreated: store.onCreated,
                      mapToolbarEnabled: false,
                      buildingsEnabled: false,
                      tiltGesturesEnabled: false,
                      markers: Set.of(trp.state.markers),
                      minMaxZoomPreference: const MinMaxZoomPreference(19, 50),
                      initialCameraPosition: trp.state.cameraPosition ?? const CameraPosition(target: LatLng(0, 0))),
                  if (trp.state.parkingSpaceSelectedUser != null)
                    Align(
                        alignment: Alignment.topRight,
                        child: IconSeeParkingSpacesReserved(onTap: store.onTapMyReserves))
                ],
              ));
        });
  }
}
