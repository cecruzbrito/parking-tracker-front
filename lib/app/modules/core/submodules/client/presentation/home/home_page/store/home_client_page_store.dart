import 'dart:async';

import 'package:estacionamento_rotativo/app/modules/core/domain/entities/parking_space_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../../domain/usecases/parking_space_consume_kafka_usecase/parking_space_consume_kafka_usecase_imp.dart';
import '../../../../../../domain/usecases/parking_space_produce_kafka_usecase/parking_space_produce_kafka_usecase_imp.dart';
import '../page/widgets/bottom_sheet_reserve_spot.dart';
import '../state/home_client_page_state.dart';

class HomeClientPageStore extends Store<HomeClientPageState> {
  HomeClientPageStore(this._getConsumerUsecase, this._putProduce) : super(HomeClientPageState.initState);

  final ParkingSpaceConsumeKafkaUsecaseImp _getConsumerUsecase;
  final ParkingSpaceProduceKafkaUsecaseImp _putProduce;

  GoogleMapController? ctr;

  void onCreated(GoogleMapController value) {
    ctr = value;
    if (ctr != null)
      ctr!.moveCamera(CameraUpdate.newCameraPosition(state.cameraPosition ?? CameraPosition(target: LatLng(0, 0))));
  }

  final keyScaffold = GlobalKey<ScaffoldState>();

  Stream<ParkingSpaceEntity>? stream;

  var session = KafkaSession([ContactPoint('192.168.3.76', 9092)]);

  void onTapInIconInNavigation(int value) => update(state.copyWith(indexCtrNavigationBar: value));

  Future<void> initializing() async {
    await _setMarkers();
    _setCameraPosition();
    await _setConsumerKafka();
  }

  Future<void> _setConsumerKafka() async {
    void setCtrStream(Stream<ParkingSpaceEntity> value) {
      stream = value;
      stream!.where(_filterParking).listen(_listen);
    }

    final response = await _getConsumerUsecase(session);
    response.fold((l) => null, setCtrStream);
  }

  Future<void> _listen(ParkingSpaceEntity? park) async {
    if (park == null) return;
    var eqv = state.parking.firstWhereOrNull((p) => p.id == park.id);
    if (eqv == null) return;
    final parking = state.parking.map((e) => e.id == eqv.id ? park : e).toList();
    final markerList = <Marker>[];
    for (var p in parking) {
      markerList.add(await _setOnTapMarker(p));
    }
    update(state.copyWith(markers: markerList, parking: parking), force: true);
  }

  bool _filterParking(ParkingSpaceEntity event) {
    var eqv = state.parking.firstWhereOrNull((p) => p.id == event.id);
    if (eqv == null) return false;
    return event.lastModification.isAfter(eqv.lastModification);
  }

  Future<void> _setMarkers() async {
    update(
        state.copyWith(parking: [
          ParkingSpaceEntity(
              id: 0,
              status: StatusParkingSpace.assessment,
              position: PositionParkingEntity(lat: -22.41280397498146, log: -45.44974965511389),
              lastModification: DateTime.parse("2023-06-25 16:37:53.292157")),
          ParkingSpaceEntity(
              id: 1,
              status: StatusParkingSpace.assessment,
              position: PositionParkingEntity(lat: -22.412494575231158, log: -45.44999136910507),
              lastModification: DateTime.parse("2023-06-25 15:48:25.304262"))
        ]),
        force: true);

    final markerList = <Marker>[];
    for (var p in state.parking) {
      markerList.add(await _setOnTapMarker(p));
    }

    update(state.copyWith(markers: markerList), force: true);
  }

  Future<Marker> _setOnTapMarker(ParkingSpaceEntity parking) async => Marker(
      icon: await parking.status.getImage(),
      markerId: MarkerId("${parking.id}"),
      position: LatLng(parking.position.lat, parking.position.log),
      onTap: () => onTapInMarker(parking));

  Future<void> onTapInMarker(ParkingSpaceEntity parking) async {
    if (parking.status != StatusParkingSpace.available) return;
    return await BottomSheetReserveSpot(onTapNegative: () {}, onTapPositive: () async => await _produceUseCase(parking))
        .show(keyScaffold.currentContext!);
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

    update(state.copyWith(cameraPosition: CameraPosition(target: LatLng(latitude, longitude))), force: true);
    if (ctr != null) ctr!.moveCamera(CameraUpdate.newCameraPosition(state.cameraPosition!));
  }

  _produceUseCase(ParkingSpaceEntity par) async {
    await _putProduce(
        session,
        ParkingSpaceEntity(
            id: par.id, lastModification: DateTime.now(), position: par.position, status: StatusParkingSpace.reserved));
  }

  dispose() {
    session.close();
  }
}
