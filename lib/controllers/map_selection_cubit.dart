import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import '../services/location_service.dart';
import '../services/geocoding_service.dart';
import 'map_selection_state.dart';

class MapSelectionCubit extends Cubit<MapSelectionState> {
  final LocationService _locationService;
  final GeocodingService _geocodingService;

  MapSelectionCubit(this._locationService, this._geocodingService)
      : super(const MapSelectionInitial());

  void selectLocation(LatLng position) {
    emit(MapLocationSelected(position, mapType: state.mapType));
  }

  void changeMapType(MapTypeEnum type) {
    if (state is MapLocationSelected) {
      emit(
        MapLocationSelected(
          (state as MapLocationSelected).position,
          mapType: type,
        ),
      );
    } else if (state is MapLocationError) {
      emit(
        MapLocationError(
          (state as MapLocationError).failure,
          debugMessage: (state as MapLocationError).debugMessage,
          mapType: type,
        ),
      );
    } else if (state is MapLocationLoading) {
      emit(MapLocationLoading(mapType: type));
    } else {
      emit(MapSelectionInitial(mapType: type));
    }
  }

  Future<void> fetchCurrentLocation() async {
    emit(MapLocationLoading(mapType: state.mapType));
    try {
      final position = await _locationService.getCurrentLocation();
      if (position != null) {
        emit(MapLocationSelected(position, mapType: state.mapType));
      } else {
        emit(
          MapLocationError(
            MapSelectionFailure.locationServicesDisabled,
            mapType: state.mapType,
          ),
        );
      }
    } catch (e) {
      emit(
        MapLocationError(
          MapSelectionFailure.unknown,
          debugMessage: e.toString(),
          mapType: state.mapType,
        ),
      );
    }
  }

  Future<void> searchLocation(String query) async {
    if (query.isEmpty) return;

    emit(MapLocationLoading(mapType: state.mapType));
    try {
      final position = await _geocodingService.searchLocation(query);
      if (position != null) {
        emit(MapLocationSelected(position, mapType: state.mapType));
      } else {
        emit(
          MapLocationError(
            MapSelectionFailure.locationNotFound,
            mapType: state.mapType,
          ),
        );
      }
    } catch (e) {
      emit(
        MapLocationError(
          MapSelectionFailure.unknown,
          debugMessage: e.toString(),
          mapType: state.mapType,
        ),
      );
    }
  }

  void clearSelection() {
    emit(MapSelectionInitial(mapType: state.mapType));
  }
}
