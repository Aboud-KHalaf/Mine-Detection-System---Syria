import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

enum MapTypeEnum { defaultMap, satellite, terrain }

enum MapThemeEnum { light, dark }

enum MapSelectionFailure {
  locationServicesDisabled,
  locationNotFound,
  unknown,
}

abstract class MapSelectionState extends Equatable {
  final MapTypeEnum mapType;
  final MapThemeEnum mapTheme;

  const MapSelectionState({
    this.mapType = MapTypeEnum.defaultMap,
    this.mapTheme = MapThemeEnum.light,
  });

  @override
  List<Object?> get props => [mapType, mapTheme];
}

class MapSelectionInitial extends MapSelectionState {
  const MapSelectionInitial({super.mapType, super.mapTheme});
}

class MapLocationLoading extends MapSelectionState {
  const MapLocationLoading({super.mapType, super.mapTheme});
}

class MapLocationSelected extends MapSelectionState {
  final LatLng position;

  const MapLocationSelected(this.position, {super.mapType, super.mapTheme});

  @override
  List<Object?> get props => [position, mapType, mapTheme];
}

class MapLocationError extends MapSelectionState {
  final MapSelectionFailure failure;
  final String? debugMessage;

  const MapLocationError(
    this.failure, {
    this.debugMessage,
    super.mapType,
    super.mapTheme,
  });

  @override
  List<Object?> get props => [failure, debugMessage, mapType, mapTheme];
}
