import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controllers/map_selection_cubit.dart';

class CurrentLocationButton extends StatelessWidget {
  const CurrentLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: FloatingActionButton(
        heroTag: 'current_location_fab',
        onPressed: () {
          context.read<MapSelectionCubit>().fetchCurrentLocation();
        },
        backgroundColor: theme.colorScheme.surface,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        child: Icon(
          Icons.my_location,
          color: theme.colorScheme.onSurface,
          size: 28.0,
        ),
      ),
    );
  }
}
