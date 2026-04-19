import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class MapSelectionState extends Equatable {
  const MapSelectionState();

  @override
  List<Object?> get props => [];
}

class MapSelectionInitial extends MapSelectionState {}

class MapLocationSelected extends MapSelectionState {
  final LatLng position;

  const MapLocationSelected(this.position);

  @override
  List<Object?> get props => [position];
}
