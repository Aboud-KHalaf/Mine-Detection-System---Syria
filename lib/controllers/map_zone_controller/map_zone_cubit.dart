import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/zone_service.dart';
import 'map_zone_state.dart';
import '../../core/errors/exceptions.dart';

class MapZoneCubit extends Cubit<MapZoneState> {
  final ZoneService zoneService;

  MapZoneCubit(this.zoneService) : super(MapZoneInitial());

  Future<void> fetchZones() async {
    emit(MapZoneLoading());
    try {
      final zones = await zoneService.getAllZones();
      emit(MapZoneLoaded(zones));
    } on ApiException catch (e) {
      emit(MapZoneError(MapZoneFailure.api, serverMessage: e.message));
    } on OfflineException catch (_) {
      // In a real scenario we could check the cached zones anyway since zoneService returns them
      // on OfflineException, but zoneService already handles caching and returning them
      // Let's rely on zoneService returning the cached ones instead of throwing
      emit(const MapZoneError(MapZoneFailure.offline));
    } catch (e) {
      emit(MapZoneError(MapZoneFailure.unknown, debugMessage: e.toString()));
    }
  }
}
