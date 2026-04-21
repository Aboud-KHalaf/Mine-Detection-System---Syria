import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controllers/map_selection_cubit.dart';
import '../../../controllers/map_selection_state.dart';
import '../../../controllers/map_zone_cubit.dart';
import '../../../controllers/map_zone_state.dart';

class HomeMapView extends StatefulWidget {
  const HomeMapView({super.key});

  @override
  State<HomeMapView> createState() => _HomeMapViewState();
}

class _HomeMapViewState extends State<HomeMapView> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    // Fetch zones from API on initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapZoneCubit>().fetchZones();
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<MapZoneCubit, MapZoneState>(
      builder: (context, zoneState) {
        return BlocListener<MapSelectionCubit, MapSelectionState>(
          listener: (context, selectionState) {
            if (selectionState is MapLocationSelected) {
              _mapController.move(selectionState.position, 15.0);
            } else if (selectionState is MapLocationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(selectionState.message),
                  backgroundColor: colors.error,
                ),
              );
            }
          },
          child: BlocBuilder<MapSelectionCubit, MapSelectionState>(
            builder: (context, selectionState) {
              LatLng? selectedPoint;
              if (selectionState is MapLocationSelected) {
                selectedPoint = selectionState.position;
              }

              // Prepare layers for polygons and circles
              List<Polygon> apiPolygons = [];
              List<CircleMarker> apiCircles = [];

              if (zoneState is MapZoneLoaded) {
                for (var zone in zoneState.zones) {
                  final color = zone.statusColor;

                  if (zone.shapeType.toLowerCase() == 'circle' ||
                      zone.coordinates?['type'] == 'Point') {
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
                  } else {
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
                }
              }

              return Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: const LatLng(34.8021, 38.9968),
                      initialZoom: 6.0,
                      onLongPress: (tapPosition, point) {
                        context.read<MapSelectionCubit>().selectLocation(point);

                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Pinned hazard at: ${point.latitude.toStringAsFixed(4)}, ${point.longitude.toStringAsFixed(4)}',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.mds',
                      ),
                      if (apiPolygons.isNotEmpty)
                        PolygonLayer(polygons: apiPolygons),
                      if (apiCircles.isNotEmpty)
                        CircleLayer(circles: apiCircles),
                      if (selectedPoint != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: selectedPoint,
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.location_on,
                                color: colors.primary,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  if (zoneState is MapZoneLoading || selectionState is MapLocationLoading)
                    Positioned(
                      top: 16,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(selectionState is MapLocationLoading 
                                  ? 'Fetching your location...'
                                  : 'Loading safe zones...'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (zoneState is MapZoneError)
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Center(
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              context.read<MapZoneCubit>().fetchZones(),
                          icon: const Icon(Icons.refresh),
                          label: Text('Error: ${zoneState.message}. Retry?'),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
