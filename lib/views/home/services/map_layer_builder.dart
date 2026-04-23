import 'package:flutter_map/flutter_map.dart';
import 'package:mds/controllers/map_zone_controller/map_zone_state.dart';

class MapLayerBuilder {
  static List<Polygon> buildPolygons(MapZoneLoaded zoneState) {
    List<Polygon> apiPolygons = [];
    for (var zone in zoneState.zones) {
      if (zone.shapeType.toLowerCase() == 'circle' ||
          zone.coordinates?['type'] == 'Point') {
        continue;
      }

      final color = zone.statusColor;
      final polygonRings = zone.getPolygonPoints;
      for (var ring in polygonRings) {
        apiPolygons.add(
          Polygon(
            points: ring,
            color: color.withAlpha(80),
            borderColor: color,
            borderStrokeWidth: 2,
          ),
        );
      }
    }
    return apiPolygons;
  }

  static List<CircleMarker> buildCircles(MapZoneLoaded zoneState) {
    List<CircleMarker> apiCircles = [];
    for (var zone in zoneState.zones) {
      if (zone.shapeType.toLowerCase() == 'circle' ||
          zone.coordinates?['type'] == 'Point') {
        final color = zone.statusColor;
        final center = zone.getCircleCenter;
        if (center != null) {
          apiCircles.add(
            CircleMarker(
              point: center,
              radius: zone.shapeRadius ?? 500, // Default 500m if null
              useRadiusInMeter: true,
              color: color.withAlpha(80),
              borderColor: color,
              borderStrokeWidth: 2,
            ),
          );
        }
      }
    }
    return apiCircles;
  }
}
