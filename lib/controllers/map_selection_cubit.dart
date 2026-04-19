import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'map_selection_state.dart';

class MapSelectionCubit extends Cubit<MapSelectionState> {
  MapSelectionCubit() : super(MapSelectionInitial());

  void selectLocation(LatLng position) {
    emit(MapLocationSelected(position));
  }

  void clearSelection() {
    emit(MapSelectionInitial());
  }
}
