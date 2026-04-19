import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controllers/map_selection_cubit.dart';
import '../../../controllers/map_selection_state.dart';

class HomeMapView extends StatelessWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<MapSelectionCubit, MapSelectionState>(
      builder: (context, selectionState) {
        LatLng? selectedPoint;
        if (selectionState is MapLocationSelected) {
          selectedPoint = selectionState.position;
        }

        return FlutterMap(
          options: MapOptions(
            initialCenter: const LatLng(34.8021, 38.9968),
            initialZoom: 6.0,
            onLongPress: (tapPosition, point) {
              context.read<MapSelectionCubit>().selectLocation(point);
              
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Pinned hazard at: ${point.latitude.toStringAsFixed(4)}, ${point.longitude.toStringAsFixed(4)}'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.mds',
            ),
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
            // Example danger zone polygon
            PolygonLayer(
              polygons: [
                Polygon(
                  points: const [
                    LatLng(34.0, 38.0),
                    LatLng(34.0, 39.0),
                    LatLng(35.0, 39.0),
                    LatLng(35.0, 38.0),
                  ],
                  color: Colors.redAccent.withAlpha(80),
                  borderColor: Colors.red,
                  borderStrokeWidth: 2,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
