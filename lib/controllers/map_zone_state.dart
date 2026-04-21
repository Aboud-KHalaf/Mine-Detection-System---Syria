import 'package:equatable/equatable.dart';
import '../models/zone_model.dart';

enum MapZoneFailure {
  api,
  offline,
  unknown,
}

abstract class MapZoneState extends Equatable {
  const MapZoneState();
  
  @override
  List<Object?> get props => [];
}

class MapZoneInitial extends MapZoneState {}

class MapZoneLoading extends MapZoneState {}

class MapZoneLoaded extends MapZoneState {
  final List<ZoneModel> zones;
  const MapZoneLoaded(this.zones);

  @override
  List<Object?> get props => [zones];
}

class MapZoneError extends MapZoneState {
  final MapZoneFailure failure;
  final String? serverMessage;
  final String? debugMessage;

  const MapZoneError(
    this.failure, {
    this.serverMessage,
    this.debugMessage,
  });

  @override
  List<Object?> get props => [failure, serverMessage, debugMessage];
}
