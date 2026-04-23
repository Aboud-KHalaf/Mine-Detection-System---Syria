import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:mds/controllers/map_selection_controller/map_selection_state.dart';
import 'package:mds/controllers/map_zone_controller/map_zone_state.dart';
import 'package:mds/core/extensions/map_type_extensions.dart';
import 'package:mds/views/home/services/map_layer_builder.dart';

class HomeMapCanvas extends StatelessWidget {
  const HomeMapCanvas({
    required this.mapController,
    required this.selectionState,
    required this.zoneState,
    required this.onMapLongPress,
    super.key,
  });

  final MapController mapController;
  final MapSelectionState selectionState;
  final MapZoneState zoneState;
  final void Function(TapPosition tapPosition, LatLng point) onMapLongPress;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    LatLng? selectedPoint;

    if (selectionState is MapLocationSelected) {
      selectedPoint = (selectionState as MapLocationSelected).position;
    }

    final polygons = zoneState is MapZoneLoaded
        ? MapLayerBuilder.buildPolygons(zoneState as MapZoneLoaded)
        : <Polygon>[];
    final circles = zoneState is MapZoneLoaded
        ? MapLayerBuilder.buildCircles(zoneState as MapZoneLoaded)
        : <CircleMarker>[];

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: const LatLng(34.8021, 38.9968),
        initialZoom: 6.0,
        onLongPress: onMapLongPress,
      ),
      children: [
        ColorFiltered(
          colorFilter: selectionState.mapTheme == MapThemeEnum.dark
              ? const ColorFilter.matrix([
                  -0.2126,
                  -0.7152,
                  -0.0722,
                  0,
                  255,
                  -0.2126,
                  -0.7152,
                  -0.0722,
                  0,
                  255,
                  -0.2126,
                  -0.7152,
                  -0.0722,
                  0,
                  255,
                  0,
                  0,
                  0,
                  1,
                  0,
                ])
              : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
          child: TileLayer(
            urlTemplate: selectionState.mapType.tileUrl(
              selectionState.mapTheme,
            ),
            userAgentPackageName: 'com.example.mds',
            retinaMode: true,
          ),
        ),
        if (polygons.isNotEmpty) PolygonLayer(polygons: polygons),
        if (circles.isNotEmpty) CircleLayer(circles: circles),
        if (selectedPoint != null)
          MarkerLayer(
            markers: [
              Marker(
                point: selectedPoint,
                width: 40,
                height: 40,
                child: Icon(Icons.location_on, color: colors.primary, size: 40),
              ),
            ],
          ),
      ],
    );
  }
}
