import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

enum MapTypeEnum { defaultMap, satellite, terrain }

enum MapSelectionFailure {
  locationServicesDisabled,
  locationNotFound,
  unknown,
}

abstract class MapSelectionState extends Equatable {
  final MapTypeEnum mapType;

  const MapSelectionState({this.mapType = MapTypeEnum.defaultMap});

  @override
  List<Object?> get props => [mapType];
}

class MapSelectionInitial extends MapSelectionState {
  const MapSelectionInitial({super.mapType});
}

class MapLocationLoading extends MapSelectionState {
  const MapLocationLoading({super.mapType});
}

class MapLocationSelected extends MapSelectionState {
  final LatLng position;

  const MapLocationSelected(this.position, {super.mapType});

  @override
  List<Object?> get props => [position, mapType];
}

class MapLocationError extends MapSelectionState {
  final MapSelectionFailure failure;
  final String? debugMessage;

  const MapLocationError(
    this.failure, {
    this.debugMessage,
    super.mapType,
  });

  @override
  List<Object?> get props => [failure, debugMessage, mapType];
}
