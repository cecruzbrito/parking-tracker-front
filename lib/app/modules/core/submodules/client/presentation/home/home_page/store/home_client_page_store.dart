import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/entities/parking_space_entity.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/entities/user_entity.dart';
import 'package:estacionamento_rotativo/app/modules/core/domain/repositories/core_repository/core_repository.dart';
import 'package:estacionamento_rotativo/app/shared/domain/errors/erros.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../../domain/usecases/parking_space_consume_kafka_usecase/parking_space_consume_kafka_usecase_imp.dart';
import '../../../../../../domain/usecases/parking_space_get_all_api/parking_space_get_all_api_imp.dart';
import '../../../../../../domain/usecases/parking_space_produce_kafka_usecase/parking_space_produce_kafka_usecase_imp.dart';
import '../page/widgets/bottom_sheet_parking_space.dart';
import '../page/widgets/bottom_sheet_reserve_spot.dart';
import '../state/home_client_page_state.dart';

class HomeClientPageStore extends Store<HomeClientPageState> {
  HomeClientPageStore(this._getConsumerUsecase, this._putProduce, this._getAllParkingSpaces, this._repository)
      : super(HomeClientPageState.initState);

  final ParkingSpaceProduceKafkaUsecaseImp _putProduce;
  final ParkingSpaceConsumeKafkaUsecaseImp _getConsumerUsecase;
  final ParkingSpaceGetAllApiImp _getAllParkingSpaces;
  final CoreRepository _repository;

  final keyScaffold = GlobalKey<ScaffoldState>();

  Stream<ParkingSpaceEntity>? stream;

  var session = KafkaSession([ContactPoint('192.168.3.76', 9092)]);

  Future<void> initializing() async {
    await _setConsumerKafka();
    await _getParkingSpacesApi();
  }

  GoogleMapController? ctr;

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
    if (park.vehicle == null) return;

    if (park.vehicle!.idClient != (_repository.getUserEntity()! as ClientUserEntity).idClient) return;

    if (state.parkingSpaceSelectedUser == null && (park.status == StatusParkingSpace.reserved)) {
      return _setParkingUser(park);
    }
    if (state.parkingSpaceSelectedUser == null) return;

    if (state.parkingSpaceSelectedUser!.id == park.id && park.status == StatusParkingSpace.available) {
      return _setParkingUser(null);
    }
  }

  bool _filterParking(ParkingSpaceEntity event) {
    var eqv = state.parking.firstWhereOrNull((p) => p.id == event.id);
    if (eqv == null) return false;
    return event.lastModification.isAfter(eqv.lastModification);
  }

  Future<void> _getParkingSpacesApi() async {
    setLoading(true);
    final response = await _getAllParkingSpaces();
    setLoading(false);

    response.fold((l) => setError(l, force: true), _setMarkers);
  }

  Future<void> _setMarkers(List<ParkingSpaceEntity> result) async {
    update(state.copyWith(
        parkingSpaceSelectedUser: result.firstWhereOrNull((p) =>
            p.vehicle != null &&
            p.status == StatusParkingSpace.reserved &&
            p.vehicle!.idClient == (_repository.getUserEntity() as ClientUserEntity).idClient)));
    final markerList = <Marker>[];
    for (var p in result) {
      markerList.add(await _setOnTapMarker(p));
    }
    update(state.copyWith(markers: markerList, parking: result), force: true);
    _setCameraPosition();
  }

  Future<Marker> _setOnTapMarker(ParkingSpaceEntity parking) async => Marker(
      icon: await parking.status.getImage(),
      markerId: MarkerId("${parking.id}"),
      position: LatLng(parking.position.lat, parking.position.log),
      onTap: () async => await onTapInParkingScapeInMap(parking));

  Future<void> onTapInParkingScapeInMap(ParkingSpaceEntity parking) async {
    if (state.parkingSpaceSelectedUser != null) {
      if (state.parkingSpaceSelectedUser!.id == parking.id) return await onTapMyReserves();

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
        vehicle: (_repository.getUserEntity()! as ClientUserEntity).vehicle,
        reservation: DateTime.now().add(const Duration(seconds: 15)),
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
    if (state.parkingSpaceSelectedUser == null) return;
    await BottomSheetParkingSpace(
            onTapInformThatArrived: () async => await _informPendingParking(StatusParkingSpace.pendingArrival),
            onTapInformThatExit: () async => await _informPendingParking(StatusParkingSpace.pendingExit),
            park: state.parkingSpaceSelectedUser!)
        .show(keyScaffold.currentContext!);
  }

  Future<void> _informPendingParking(StatusParkingSpace status) async {
    final response = await _produceUseCase(ParkingSpaceEntity(
      id: state.parkingSpaceSelectedUser!.id,
      reservation: state.parkingSpaceSelectedUser!.reservation,
      status: status,
      position: state.parkingSpaceSelectedUser!.position,
      lastModification: DateTime.now(),
      vehicle: (_repository.getUserEntity()! as ClientUserEntity).vehicle,
    ));

    response.fold((l) => setError(l, force: true),
        (r) => update(state.resetSelectedParkingSpace(parkingSpaceSelectedUser: null)));
  }

  dispose() {
    session.close();
  }
}
