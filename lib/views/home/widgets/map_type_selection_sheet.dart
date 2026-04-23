import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mds/controllers/map_selection_controller/map_selection_cubit.dart';
import 'package:mds/controllers/map_selection_controller/map_selection_state.dart';
import 'package:mds/l10n/app_localizations.dart';

class MapTypeSelectionSheet extends StatelessWidget {
  const MapTypeSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.mapType,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 24),
          BlocBuilder<MapSelectionCubit, MapSelectionState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _MapTypeOption(
                    type: MapTypeEnum.defaultMap,
                    label: l10n.defaultMap,
                    icon: Icons.map,
                    isSelected: state.mapType == MapTypeEnum.defaultMap,
                  ),
                  _MapTypeOption(
                    type: MapTypeEnum.satellite,
                    label: l10n.satellite,
                    icon: Icons.satellite_alt,
                    isSelected: state.mapType == MapTypeEnum.satellite,
                  ),
                  _MapTypeOption(
                    type: MapTypeEnum.terrain,
                    label: l10n.terrain,
                    icon: Icons.terrain,
                    isSelected: state.mapType == MapTypeEnum.terrain,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _MapTypeOption extends StatelessWidget {
  final MapTypeEnum type;
  final String label;
  final IconData icon;
  final bool isSelected;

  const _MapTypeOption({
    required this.type,
    required this.label,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        context.read<MapSelectionCubit>().changeMapType(type);
        Navigator.pop(context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isSelected
                  ? colors.primaryContainer
                  : colors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: colors.primary, width: 2)
                  : Border.all(color: Colors.transparent),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: colors.primary.withAlpha(50),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              icon,
              size: 32,
              color: isSelected
                  ? colors.onPrimaryContainer
                  : colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: textTheme.labelMedium?.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? colors.primary : colors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
