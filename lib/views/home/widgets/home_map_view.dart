import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mds/controllers/map_selection_controller/map_selection_cubit.dart';
import 'package:mds/controllers/map_selection_controller/map_selection_state.dart';
import 'package:mds/controllers/map_zone_controller/map_zone_cubit.dart';
import 'package:mds/controllers/map_zone_controller/map_zone_state.dart';
import 'package:mds/views/components/map/map_loading_overlay.dart';
import 'package:mds/views/components/map/map_error_overlay.dart';
import 'package:mds/views/home/widgets/home_map_canvas.dart';
import 'package:mds/l10n/app_localizations.dart';

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

  void _showPinnedHazardSnackBar(LatLng point) {
    final l10n = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            l10n.pinnedHazardAt(
              point.latitude.toStringAsFixed(4),
              point.longitude.toStringAsFixed(4),
            ),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  void _onMapLongPress(TapPosition tapPosition, LatLng point) {
    context.read<MapSelectionCubit>().selectLocation(point);
    _showPinnedHazardSnackBar(point);
  }

  void _onSelectionStateChanged(
    BuildContext context,
    MapSelectionState selectionState,
  ) {
    if (selectionState is MapLocationSelected) {
      _mapController.move(selectionState.position, 15.0);
    } else if (selectionState is MapLocationError) {
      final l10n = AppLocalizations.of(context)!;
      final colors = Theme.of(context).colorScheme;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_localizeSelectionError(l10n, selectionState)),
          backgroundColor: colors.error,
        ),
      );
    }
  }

  String _localizeSelectionError(
    AppLocalizations l10n,
    MapLocationError error,
  ) {
    return switch (error.failure) {
      MapSelectionFailure.locationServicesDisabled =>
        l10n.mapErrorLocationServicesDisabled,
      MapSelectionFailure.locationNotFound => l10n.mapErrorLocationNotFound,
      MapSelectionFailure.unknown => l10n.mapErrorUnknown,
    };
  }

  String _localizeZoneError(AppLocalizations l10n, MapZoneError error) {
    return switch (error.failure) {
      MapZoneFailure.api => error.serverMessage ?? l10n.errorGenericServer,
      MapZoneFailure.offline => l10n.errorOffline,
      MapZoneFailure.unknown => l10n.errorUnknown,
    };
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
                  HomeMapCanvas(
                    mapController: _mapController,
                    selectionState: selectionState,
                    zoneState: zoneState,
                    onMapLongPress: _onMapLongPress,
                  ),
                  if (zoneState is MapZoneLoading ||
                      selectionState is MapLocationLoading)
                    MapLoadingOverlay(
                      text: selectionState is MapLocationLoading
                          ? AppLocalizations.of(context)!.fetchingLocation
                          : AppLocalizations.of(context)!.loadingSafeZones,
                    ),
                  if (zoneState is MapZoneError)
                    MapErrorOverlay(
                      message: _localizeZoneError(
                        AppLocalizations.of(context)!,
                        zoneState,
                      ),
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
}
