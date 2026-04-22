import 'package:flutter/material.dart';
import 'package:mds/l10n/app_localizations.dart';
import '../widgets/settings_language_section.dart';
import '../widgets/settings_map_type_section.dart';
import '../widgets/settings_map_theme_section.dart';
import '../widgets/settings_map_preview.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        title: Text(
          l10n.operationalSettings,
          style: textTheme.titleMedium?.copyWith(
            letterSpacing: 1.05,
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SettingsMapPreview(),
          const SettingsLanguageSection(),
          const SizedBox(height: 24),
          const SettingsMapTypeSection(),
          const SizedBox(height: 24),
          const SettingsMapThemeSection(),
          const SizedBox(height: 32),
          Center(
            child: Text(
              l10n.appVersion('1.0.0'),
              style: textTheme.labelSmall?.copyWith(
                color: colors.onSurfaceVariant.withAlpha(128),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
