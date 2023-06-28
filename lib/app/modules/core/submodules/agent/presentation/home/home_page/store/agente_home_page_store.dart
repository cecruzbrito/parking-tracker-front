import 'package:estacionamento_rotativo/app/modules/core/domain/entities/user_entity.dart';
import 'package:estacionamento_rotativo/app/modules/core/submodules/agent/presentation/home/home_page/state/agent_home_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kafkabr/kafka.dart';

import '../../../../../../domain/entities/parking_space_entity.dart';
import '../../../../../../domain/repositories/core_repository/core_repository.dart';
import '../../../../../../domain/usecases/parking_space_consume_kafka_usecase/parking_space_consume_kafka_usecase_imp.dart';
import '../../../../../../domain/usecases/parking_space_get_all_api/parking_space_get_all_api_imp.dart';
import '../../../../../../domain/usecases/parking_space_produce_autuacao_kafka/parking_space_produce_autuacao_kafka_imp.dart';
import '../../../../../../domain/usecases/parking_space_produce_kafka_usecase/parking_space_produce_kafka_usecase_imp.dart';
import '../../../../../../domain/usecases/parkins_space_consume_agente_check_status_usecase/parkins_space_consume_agente_check_status_usecase_imp.dart';
import '../page/widgets/bottom_sheet_arrived_parking.dart';
import '../page/widgets/bottom_sheet_exit_parking.dart';
import '../page/widgets/bottom_sheet_has_avaliable_parking.dart';
import '../page/widgets/bottom_sheet_see_notifications.dart';

class AgentHomePageStore extends Store<AgentHomePageState> {
  AgentHomePageStore(this._putProduce, this._usecaseAutuacao, this._getConsumerUsecase, this._getAllParkingSpaces,
      this._consumeAgenteCheckStatus, this._repository)
      : super(AgentHomePageState.initState);
  final ParkingSpaceProduceAutuacaoKafkaImp _usecaseAutuacao;
  final ParkingSpaceProduceKafkaUsecaseImp _putProduce;
  final ParkingSpaceConsumeKafkaUsecaseImp _getConsumerUsecase;
  final ParkingSpaceGetAllApiImp _getAllParkingSpaces;
  final ParkingSpaceConsumeAgenteCheckStatusKafkaUsecaseImp _consumeAgenteCheckStatus;
  final CoreRepository _repository;

  Stream<ParkingSpaceEntity>? streamVagas;
  Stream<ParkingSpaceEntity>? streamNotification;

  var session = KafkaSession([ContactPoint('192.168.3.76', 9092)]);

  final keyScaffold = GlobalKey<ScaffoldState>();

  GoogleMapController? ctr;

  final _dateLoginHasDone = DateTime.now();

  void onCreated(GoogleMapController value) {
    ctr = value;
    if (ctr != null) {
      ctr!.moveCamera(
          CameraUpdate.newCameraPosition(state.cameraPosition ?? const CameraPosition(target: LatLng(0, 0))));
    }
  }

  Future<void> initializing() async {
    await _setConsumerKafka();
    await _getParkingSpacesApi();
  }

  Future<void> _getParkingSpacesApi() async {
    setLoading(true);
    final response = await _getAllParkingSpaces();
    setLoading(false);

    response.fold((l) => setError(l, force: true), _setMarkers);
  }

  void onTapInIconInNavigation(int value) => update(state.copyWith(indexCtrNavigationBar: value));

  Future<void> _setMarkers(List<ParkingSpaceEntity> result) async {
    final markerList = <Marker>[];
    for (var p in result) {
      markerList.add(await _setOnTapMarker(p));
    }
    update(state.copyWith(markers: markerList, parking: result), force: true);
    _setCameraPosition();
  }

  Future<void> _setConsumerKafka() async {
    void setCtrStreamVagas(Stream<ParkingSpaceEntity> value) {
      streamVagas = value;
      streamVagas!.where(_filterParking).listen(_listenCallbacksStreamVagas);
    }

    void setCtrStreamNotification(Stream<ParkingSpaceEntity> value) {
      streamNotification = value;
      streamNotification!.where(_filterNotification).listen(_listenNotification);
    }

    final response = await _getConsumerUsecase(session);
    response.fold((l) => setError(l, force: true), setCtrStreamVagas);

    final responseCheckNotifications = await _consumeAgenteCheckStatus(session);

    responseCheckNotifications.fold((l) => setError(l, force: true), setCtrStreamNotification);
  }

  _listenNotification(ParkingSpaceEntity park) {
    var eqv = state.notifications.firstWhereOrNull((p) => p.id == park.id);
    var aux = state.notifications.map((e) => e).toList();
    eqv == null ? aux.add(park) : aux = state.notifications.map((e) => e.id == eqv.id ? park : e).toList();
    update(state.copyWith(notifications: aux));
  }

  bool _filterNotification(ParkingSpaceEntity park) {
    if (park.lastModification.isBefore(_dateLoginHasDone)) return false;
    final eqv = state.notifications.firstWhereOrNull((e) => e.id == park.id);
    if (eqv != null) {
      return park.lastModification.isAfter(eqv.lastModification);
    }
    return true;
  }

  Future<void> _listenCallbacksStreamVagas(ParkingSpaceEntity park) async {
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

  Future<Marker> _setOnTapMarker(ParkingSpaceEntity parking) async => Marker(
      icon: await parking.status.getImage(),
      markerId: MarkerId("${parking.id}"),
      position: LatLng(parking.position.lat, parking.position.log),
      onTap: () async => await onTapInParkingScapeInMap(parking));

  Future<void> onTapInParkingScapeInMap(ParkingSpaceEntity parking) async {
    if (![
      StatusParkingSpace.assessment,
      StatusParkingSpace.pending,
      StatusParkingSpace.pendingExit,
      StatusParkingSpace.pendingArrival
    ].contains(parking.status)) return;

    if (parking.status == StatusParkingSpace.pendingExit) {
      return await BottomSheetExitParking(
        park: parking,
        onTapConfirm: () async => await _produceAvaliabeParkingSpace(parking),
        onTapAssessment: () async => await _produceAssessmentParkingSpace(parking),
      ).show(keyScaffold.currentContext!);
    }

    if (parking.status == StatusParkingSpace.pendingArrival) {
      return await BottomSheetArrivedParking(
        park: parking,
        onTapAvaliable: () async => await _produceAvaliabeParkingSpace(parking),
        onTapReserved: () async => await _produceReservedarkingSpace(parking),
      ).show(keyScaffold.currentContext!);
    }

    if (parking.status == StatusParkingSpace.assessment) {
      return await BottomSheetHasAvaliableParking(
        park: parking,
        onTapAvaliable: () async => await _produceAvaliabeParkingSpace(parking),
      ).show(keyScaffold.currentContext!);
    }
  }

  _produceAvaliabeParkingSpace(ParkingSpaceEntity park) async => _putProduce(
      session,
      ParkingSpaceEntity(
          id: park.id,
          lastModification: DateTime.now(),
          position: park.position,
          status: StatusParkingSpace.available));

  _produceAssessmentParkingSpace(ParkingSpaceEntity park) async {
    await _putProduce(
        session,
        ParkingSpaceEntity(
            id: park.id,
            lastModification: DateTime.now(),
            position: park.position,
            status: StatusParkingSpace.assessment,
            reservation: park.reservation,
            vehicle: park.vehicle));
    var response = await _usecaseAutuacao(
        session, (_repository.getUserEntity() as AgentUserEntity).idAgent, park.vehicle!.licensePlate);
    response.fold((l) => null, (r) => null);
  }

  _produceReservedarkingSpace(ParkingSpaceEntity park) async => _putProduce(
      session,
      ParkingSpaceEntity(
          id: park.id,
          lastModification: DateTime.now(),
          position: park.position,
          status: StatusParkingSpace.reserved,
          reservation: park.reservation,
          vehicle: park.vehicle));

  onTapIconNotifications() async {
    await BottomSheetSeeNotification(onTapSeeVagas: _onTapInSeeInMap, parks: state.notifications)
        .show(keyScaffold.currentContext!);
  }

  _onTapInSeeInMap(ParkingSpaceEntity p) async {
    await ctr!.animateCamera(CameraUpdate.newLatLng(LatLng(p.position.lat, p.position.log)));
    final eqv = state.parking.firstWhereOrNull((e) => e.id == p.id);
    if (eqv == null) {
      update(state.copyWith(notifications: state.notifications.where((e) => e != p).toList()));
      return;
    }
    await onTapInParkingScapeInMap(eqv);
  }

  dispose() {
    session.close();
  }
}
