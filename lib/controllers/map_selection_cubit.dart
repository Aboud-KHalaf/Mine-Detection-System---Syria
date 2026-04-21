import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import '../services/location_service.dart';
import 'map_selection_state.dart';

class MapSelectionCubit extends Cubit<MapSelectionState> {
  final LocationService _locationService;

  MapSelectionCubit(this._locationService) : super(MapSelectionInitial());

  void selectLocation(LatLng position) {
    emit(MapLocationSelected(position));
  }

  Future<void> fetchCurrentLocation() async {
    emit(MapLocationLoading());
    try {
      final position = await _locationService.getCurrentLocation();
      if (position != null) {
        emit(MapLocationSelected(position));
      } else {
        print('Could not get location. Please enable location services.');
        emit(
          const MapLocationError(
            'Could not get location. Please enable location services.',
          ),
        );
      }
    } catch (e) {
      print(e);
      emit(MapLocationError(e.toString()));
    }
  }

  void clearSelection() {
    emit(MapSelectionInitial());
  }
}
