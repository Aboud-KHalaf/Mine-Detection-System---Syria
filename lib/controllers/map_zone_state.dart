import 'package:equatable/equatable.dart';
import '../models/zone_model.dart';

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
  final String message;
  const MapZoneError(this.message);

  @override
  List<Object?> get props => [message];
}
