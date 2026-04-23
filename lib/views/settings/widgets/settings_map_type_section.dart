import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mds/controllers/map_selection_controller/map_selection_cubit.dart';
import 'package:mds/controllers/map_selection_controller/map_selection_state.dart';
import 'package:mds/l10n/app_localizations.dart';

class SettingsMapTypeSection extends StatelessWidget {
  const SettingsMapTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            l10n.mapType,
            style: textTheme.labelSmall?.copyWith(
              color: colors.primary,
              letterSpacing: 1.1,
            ),
          ),
        ),
        BlocBuilder<MapSelectionCubit, MapSelectionState>(
          builder: (context, state) {
            return Card(
              color: colors.surfaceContainerLow,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    _MapTypeItem(
                      type: MapTypeEnum.defaultMap,
                      label: l10n.defaultMap,
                      icon: Icons.map,
                      isSelected: state.mapType == MapTypeEnum.defaultMap,
                    ),
                    const SizedBox(width: 12),
                    _MapTypeItem(
                      type: MapTypeEnum.satellite,
                      label: l10n.satellite,
                      icon: Icons.satellite_alt,
                      isSelected: state.mapType == MapTypeEnum.satellite,
                    ),
                    const SizedBox(width: 12),
                    _MapTypeItem(
                      type: MapTypeEnum.terrain,
                      label: l10n.terrain,
                      icon: Icons.terrain,
                      isSelected: state.mapType == MapTypeEnum.terrain,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _MapTypeItem extends StatelessWidget {
  final MapTypeEnum type;
  final String label;
  final IconData icon;
  final bool isSelected;

  const _MapTypeItem({
    required this.type,
    required this.label,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<MapSelectionCubit>().changeMapType(type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? colors.primaryContainer
                : colors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(4), // ROUND_FOUR
            border: isSelected
                ? Border.all(color: colors.primary, width: 1.5)
                : null,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? colors.onPrimaryContainer
                    : colors.onSurfaceVariant,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: textTheme.labelSmall?.copyWith(
                  color: isSelected
                      ? colors.onPrimaryContainer
                      : colors.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
