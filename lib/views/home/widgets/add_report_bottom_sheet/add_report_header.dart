import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:mds/core/theme/app_theme_tokens.dart';
import 'package:mds/l10n/app_localizations.dart';

class AddReportHeader extends StatelessWidget {
  final LatLng position;

  const AddReportHeader({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colors.onSurfaceVariant.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: AppThemeTokens.spacingLg),
        Text(
          l10n.submitHazardReport,
          style: textTheme.titleMedium?.copyWith(
            color: colors.error,
            letterSpacing: 1.05,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppThemeTokens.spacingSm),
        Text(
          l10n.linkedLocation(
            position.latitude.toStringAsFixed(4),
            position.longitude.toStringAsFixed(4),
          ),
          style: textTheme.labelSmall?.copyWith(
            color: colors.onSurfaceVariant,
            letterSpacing: 1.1,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
