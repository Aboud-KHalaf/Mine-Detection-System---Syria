import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:hive_ce/hive.dart';
import '../services/location_service.dart';
import '../services/geocoding_service.dart';
import 'map_selection_state.dart';

class MapSelectionCubit extends Cubit<MapSelectionState> {
  final LocationService _locationService;
  final GeocodingService _geocodingService;

  MapSelectionCubit(this._locationService, this._geocodingService)
      : super(const MapSelectionInitial()) {
    _loadSettings();
  }

  void _loadSettings() {
    final box = Hive.box('settingsBox');

    final String? savedMapType = box.get('mapType');
    final String? savedMapTheme = box.get('mapTheme');

    MapTypeEnum mapType = MapTypeEnum.defaultMap;
    MapThemeEnum mapTheme = MapThemeEnum.light;

    if (savedMapType != null) {
      mapType = MapTypeEnum.values.firstWhere(
        (e) => e.name == savedMapType,
        orElse: () => MapTypeEnum.defaultMap,
      );
    }

    if (savedMapTheme != null) {
      mapTheme = MapThemeEnum.values.firstWhere(
        (e) => e.name == savedMapTheme,
        orElse: () => MapThemeEnum.light,
      );
    }

    if (savedMapType != null || savedMapTheme != null) {
      emit(MapSelectionInitial(mapType: mapType, mapTheme: mapTheme));
    }
  }

  void selectLocation(LatLng position) {
    emit(
      MapLocationSelected(
        position,
        mapType: state.mapType,
        mapTheme: state.mapTheme,
      ),
    );
  }

  void changeMapType(MapTypeEnum type) {
    final box = Hive.box('settingsBox');
    box.put('mapType', type.name);

    if (state is MapLocationSelected) {
      emit(
        MapLocationSelected(
          (state as MapLocationSelected).position,
          mapType: type,
          mapTheme: state.mapTheme,
        ),
      );
    } else if (state is MapLocationError) {
      emit(
        MapLocationError(
          (state as MapLocationError).failure,
          debugMessage: (state as MapLocationError).debugMessage,
          mapType: type,
          mapTheme: state.mapTheme,
        ),
      );
    } else if (state is MapLocationLoading) {
      emit(MapLocationLoading(mapType: type, mapTheme: state.mapTheme));
    } else {
      emit(MapSelectionInitial(mapType: type, mapTheme: state.mapTheme));
    }
  }

  void changeMapTheme(MapThemeEnum theme) {
    final box = Hive.box('settingsBox');
    box.put('mapTheme', theme.name);

    if (state is MapLocationSelected) {
      emit(
        MapLocationSelected(
          (state as MapLocationSelected).position,
          mapType: state.mapType,
          mapTheme: theme,
        ),
      );
    } else if (state is MapLocationError) {
      emit(
        MapLocationError(
          (state as MapLocationError).failure,
          debugMessage: (state as MapLocationError).debugMessage,
          mapType: state.mapType,
          mapTheme: theme,
        ),
      );
    } else if (state is MapLocationLoading) {
      emit(MapLocationLoading(mapType: state.mapType, mapTheme: theme));
    } else {
      emit(MapSelectionInitial(mapType: state.mapType, mapTheme: theme));
    }
  }

  Future<void> fetchCurrentLocation() async {
    emit(MapLocationLoading(mapType: state.mapType, mapTheme: state.mapTheme));
    try {
      final position = await _locationService.getCurrentLocation();
      if (position != null) {
        emit(
          MapLocationSelected(
            position,
            mapType: state.mapType,
            mapTheme: state.mapTheme,
          ),
        );
      } else {
        emit(
          MapLocationError(
            MapSelectionFailure.locationServicesDisabled,
            mapType: state.mapType,
            mapTheme: state.mapTheme,
          ),
        );
      }
    } catch (e) {
      emit(
        MapLocationError(
          MapSelectionFailure.unknown,
          debugMessage: e.toString(),
          mapType: state.mapType,
          mapTheme: state.mapTheme,
        ),
      );
    }
  }

  Future<void> searchLocation(String query) async {
    if (query.isEmpty) return;

    emit(MapLocationLoading(mapType: state.mapType, mapTheme: state.mapTheme));
    try {
      final position = await _geocodingService.searchLocation(query);
      if (position != null) {
        emit(
          MapLocationSelected(
            position,
            mapType: state.mapType,
            mapTheme: state.mapTheme,
          ),
        );
      } else {
        emit(
          MapLocationError(
            MapSelectionFailure.locationNotFound,
            mapType: state.mapType,
            mapTheme: state.mapTheme,
          ),
        );
      }
    } catch (e) {
      emit(
        MapLocationError(
          MapSelectionFailure.unknown,
          debugMessage: e.toString(),
          mapType: state.mapType,
          mapTheme: state.mapTheme,
        ),
      );
    }
  }

  void clearSelection() {
    emit(MapSelectionInitial(mapType: state.mapType, mapTheme: state.mapTheme));
  }
}
