import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mds/controllers/map_selection_cubit.dart';
import 'package:mds/controllers/map_selection_state.dart';
import 'package:mds/controllers/map_zone_cubit.dart';
import 'package:mds/controllers/map_zone_state.dart';
import 'package:mds/core/extensions/map_type_extensions.dart';
import 'package:mds/views/components/map/map_loading_overlay.dart';
import 'package:mds/views/components/map/map_error_overlay.dart';
import 'package:mds/views/home/services/map_layer_builder.dart';

class HomeMapView extends StatefulWidget {
  const HomeMapView({super.key});

  @override
  State<HomeMapView> createState() => _HomeMapViewState();
}

class _HomeMapViewState extends State<HomeMapView> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    // initialize the map controller
    _mapController = MapController();

    //fetch zones after the first frame to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapZoneCubit>().fetchZones();
    });
  }

  @override
  void dispose() {
    // Dispose the map controller to free resources
    _mapController.dispose();
    super.dispose();
  }

  void _onMapLongPress(TapPosition tapPosition, LatLng point) {
    context.read<MapSelectionCubit>().selectLocation(point);

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Pinned hazard at: ${point.latitude.toStringAsFixed(4)}, ${point.longitude.toStringAsFixed(4)}',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  void _onSelectionStateChanged(
    BuildContext context,
    MapSelectionState selectionState,
  ) {
    if (selectionState is MapLocationSelected) {
      _mapController.move(selectionState.position, 15.0);
    } else if (selectionState is MapLocationError) {
      final colors = Theme.of(context).colorScheme;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(selectionState.message),
          backgroundColor: colors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapZoneCubit, MapZoneState>(
      builder: (context, zoneState) {
        return BlocListener<MapSelectionCubit, MapSelectionState>(
          listener: _onSelectionStateChanged,
          child: BlocBuilder<MapSelectionCubit, MapSelectionState>(
            builder: (context, selectionState) {
              return Stack(
                children: [
                  _buildMap(context, selectionState, zoneState),
                  if (zoneState is MapZoneLoading ||
                      selectionState is MapLocationLoading)
                    MapLoadingOverlay(
                      text: selectionState is MapLocationLoading
                          ? 'Fetching your location...'
                          : 'Loading safe zones...',
                    ),
                  if (zoneState is MapZoneError)
                    MapErrorOverlay(
                      message: zoneState.message,
                      onRetry: () => context.read<MapZoneCubit>().fetchZones(),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildMap(
    BuildContext context,
    MapSelectionState selectionState,
    MapZoneState zoneState,
  ) {
    final colors = Theme.of(context).colorScheme;
    LatLng? selectedPoint;

    if (selectionState is MapLocationSelected) {
      selectedPoint = selectionState.position;
    }

    final polygons = zoneState is MapZoneLoaded
        ? MapLayerBuilder.buildPolygons(zoneState)
        : <Polygon>[];
    final circles = zoneState is MapZoneLoaded
        ? MapLayerBuilder.buildCircles(zoneState)
        : <CircleMarker>[];

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: const LatLng(34.8021, 38.9968),
        initialZoom: 6.0,
        onLongPress: _onMapLongPress,
      ),
      children: [
        TileLayer(
          urlTemplate: selectionState.mapType.tileUrl,
          userAgentPackageName: 'com.example.mds',
          retinaMode: true,
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
