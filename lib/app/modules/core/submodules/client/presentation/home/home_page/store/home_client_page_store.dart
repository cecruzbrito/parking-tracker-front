import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/entities/parking_space_entity.dart';
import 'package:estacionamento_rotativo/app/shared/domain/errors/erros.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../../domain/usecases/parking_space_consume_kafka_usecase/parking_space_consume_kafka_usecase_imp.dart';
import '../../../../../../domain/usecases/parking_space_produce_kafka_usecase/parking_space_produce_kafka_usecase_imp.dart';
import '../page/widgets/bottom_sheet_parking_space.dart';
import '../page/widgets/bottom_sheet_reserve_spot.dart';
import '../state/home_client_page_state.dart';

class HomeClientPageStore extends Store<HomeClientPageState> {
  HomeClientPageStore(this._getConsumerUsecase, this._putProduce) : super(HomeClientPageState.initState);

  final ParkingSpaceConsumeKafkaUsecaseImp _getConsumerUsecase;
  final ParkingSpaceProduceKafkaUsecaseImp _putProduce;

  final keyScaffold = GlobalKey<ScaffoldState>();

  Stream<ParkingSpaceEntity>? stream;

  var session = KafkaSession([ContactPoint('192.168.3.76', 9092)]);

  GoogleMapController? ctr;

  Future<void> initializing() async {
    await _setMarkers();
    _setCameraPosition();
    await _setConsumerKafka();
  }

  void onCreated(GoogleMapController value) {
    ctr = value;
    if (ctr != null) {
      ctr!.moveCamera(
          CameraUpdate.newCameraPosition(state.cameraPosition ?? const CameraPosition(target: LatLng(0, 0))));
    }
  }

  void onTapInIconInNavigation(int value) => update(state.copyWith(indexCtrNavigationBar: value));

  Future<void> _setConsumerKafka() async {
    void setCtrStream(Stream<ParkingSpaceEntity> value) {
      stream = value;
      stream!.where(_filterParking).listen(_listenCallbacksStream);
    }

    final response = await _getConsumerUsecase(session);
    response.fold((l) => null, setCtrStream);
  }

  Future<void> _listenCallbacksStream(ParkingSpaceEntity? park) async {
    if (park == null) return;
    var eqv = state.parking.firstWhereOrNull((p) => p.id == park.id);
    if (eqv == null) return;

    _setParkingUserFromListen(park);

    final parking = state.parking.map((e) => e.id == eqv.id ? park : e).toList();
    final markerList = <Marker>[];
    for (var p in parking) {
      markerList.add(await _setOnTapMarker(p));
    }
    update(state.copyWith(markers: markerList, parking: parking), force: true);
  }

  void _setParkingUserFromListen(ParkingSpaceEntity park) {
    if (park.idUsuario == null) return;

    if (park.idUsuario != 2) return;

    if (state.parkingSpaceSelectedUser == null && (park.status == StatusParkingSpace.reserved)) {
      return _setParkingUser(park);
    }
    if (state.parkingSpaceSelectedUser == null) return;

    if (state.parkingSpaceSelectedUser!.id == park.id && park.status != StatusParkingSpace.reserved) {
      return _setParkingUser(null);
    }
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
              status: StatusParkingSpace.available,
              position: PositionParkingEntity(lat: -22.41280397498146, log: -45.44974965511389),
              lastModification: DateTime.parse("2023-06-25 21:20:53.292157")),
          ParkingSpaceEntity(
              id: 1,
              status: StatusParkingSpace.available,
              position: PositionParkingEntity(lat: -22.412494575231158, log: -45.44999136910507),
              lastModification: DateTime.parse("2023-06-25 21:20:25.304262")),
          ParkingSpaceEntity(
              id: 2,
              status: StatusParkingSpace.available,
              position: PositionParkingEntity(lat: -22.412635741451854, log: -45.44961414227413),
              lastModification: DateTime.parse("2023-06-25 21:30:25.304262")),
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
      onTap: () async => await onTapInParkingScapeInMap(parking));

  Future<void> onTapInParkingScapeInMap(ParkingSpaceEntity parking) async {
    if (state.parking.any((e) => e.idUsuario != null && e.idUsuario == 2 && e.status == StatusParkingSpace.reserved)) {
      return setError(const DomainFailure("Você já tem uma vaga reservada!"), force: true);
    }
    if (parking.status != StatusParkingSpace.available) {
      return setError(const DomainFailure("Essa vaga está indisponivel"), force: true);
    }

    return await BottomSheetReserveSpot(
        onTapNegative: () {},
        onTapPositive: () async => await _reserveParkingSpace(parking)).show(keyScaffold.currentContext!);
  }

  Future<void> _reserveParkingSpace(ParkingSpaceEntity parking) async {
    final response = await _produceUseCase(ParkingSpaceEntity(
        endReserved: DateTime.now().add(const Duration(hours: 1, minutes: 15)),
        idUsuario: 2,
        id: parking.id,
        lastModification: DateTime.now(),
        position: parking.position,
        status: StatusParkingSpace.reserved));

    response.fold((l) => setError(l, force: true), (r) => update(state.copyWith(parkingSpaceSelectedUser: r)));
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

  Future<Either<AppFailure, ParkingSpaceEntity>> _produceUseCase(ParkingSpaceEntity par) async =>
      await _putProduce(session, par);

  void _setParkingUser(ParkingSpaceEntity? park) =>
      update(state.resetSelectedParkingSpace(parkingSpaceSelectedUser: park), force: true);

  onTapMyReserves() async {
    await BottomSheetParkingSpace(
            onTapInformThatArrived: () async => await _informPendingParking(StatusParkingSpace.pendingArrival),
            onTapInformThatExit: () async => await _informPendingParking(StatusParkingSpace.pendingExit),
            park: state.parkingSpaceSelectedUser!)
        .show(keyScaffold.currentContext!);
  }

  Future<void> _informPendingParking(StatusParkingSpace status) async {
    final response = await _produceUseCase(ParkingSpaceEntity(
        id: state.parkingSpaceSelectedUser!.id,
        status: status,
        position: state.parkingSpaceSelectedUser!.position,
        lastModification: DateTime.now(),
        idUsuario: 2,
        endReserved: null));

    response.fold((l) => setError(l, force: true),
        (r) => update(state.resetSelectedParkingSpace(parkingSpaceSelectedUser: null)));
  }

  dispose() {
    session.close();
  }
}
