import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mds/controllers/map_selection_controller/map_selection_cubit.dart';
import 'package:mds/controllers/map_selection_controller/map_selection_state.dart';
import 'package:mds/l10n/app_localizations.dart';

class SettingsMapThemeSection extends StatelessWidget {
  const SettingsMapThemeSection({super.key});

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
            l10n.mapTheme,
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
                    _MapThemeItem(
                      theme: MapThemeEnum.light,
                      label: l10n.light,
                      icon: Icons.light_mode,
                      isSelected: state.mapTheme == MapThemeEnum.light,
                    ),
                    const SizedBox(width: 12),
                    _MapThemeItem(
                      theme: MapThemeEnum.dark,
                      label: l10n.dark,
                      icon: Icons.dark_mode,
                      isSelected: state.mapTheme == MapThemeEnum.dark,
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

class _MapThemeItem extends StatelessWidget {
  final MapThemeEnum theme;
  final String label;
  final IconData icon;
  final bool isSelected;

  const _MapThemeItem({
    required this.theme,
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
        onTap: () => context.read<MapSelectionCubit>().changeMapTheme(theme),
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
