import 'package:mds/controllers/map_selection_controller/map_selection_state.dart';

extension MapTypeExtension on MapTypeEnum {
  String tileUrl(MapThemeEnum theme) {
    switch (this) {
      case MapTypeEnum.satellite:
        return 'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}';
      case MapTypeEnum.terrain:
        return 'https://mt1.google.com/vt/lyrs=p&x={x}&y={y}&z={z}';
      case MapTypeEnum.defaultMap:
        // Note: Google's default tiles are light.
        // For dark mode, we'll return the same URL but the UI will apply a filter.
        return 'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}';
    }
  }
}
