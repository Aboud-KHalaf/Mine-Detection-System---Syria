import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mds/controllers/map_selection_controller/map_selection_cubit.dart';
import 'package:mds/controllers/map_selection_controller/map_selection_state.dart';
import 'package:mds/controllers/map_zone_controller/map_zone_cubit.dart';
import 'package:mds/controllers/map_zone_controller/map_zone_state.dart';
import 'package:mds/views/home/widgets/home_map_canvas.dart';
import 'package:flutter_map/flutter_map.dart';

class SettingsMapPreview extends StatefulWidget {
  const SettingsMapPreview({super.key});

  @override
  State<SettingsMapPreview> createState() => _SettingsMapPreviewState();
}

class _SettingsMapPreviewState extends State<SettingsMapPreview> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.primary.withAlpha(50), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: BlocBuilder<MapSelectionCubit, MapSelectionState>(
        builder: (context, selectionState) {
          // We use BlocBuilder for MapZoneCubit but with a fallback to empty state
          // to keep the preview lightweight.
          return BlocBuilder<MapZoneCubit, MapZoneState>(
            builder: (context, zoneState) {
              return HomeMapCanvas(
                mapController: _mapController,
                selectionState: selectionState,
                zoneState: zoneState,
                onMapLongPress: (_, __) {},
              );
            },
          );
        },
      ),
    );
  }
}
