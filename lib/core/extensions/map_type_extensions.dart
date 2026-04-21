import 'package:mds/controllers/map_selection_state.dart';

extension MapTypeExtension on MapTypeEnum {
  String get tileUrl {
    switch (this) {
      case MapTypeEnum.satellite:
        return 'https://mt1.google.com/vt/lyrs=y&x={x}&y={y}&z={z}';
      case MapTypeEnum.terrain:
        return 'https://mt1.google.com/vt/lyrs=p&x={x}&y={y}&z={z}';
      case MapTypeEnum.defaultMap:
        return 'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}';
    }
  }
}
