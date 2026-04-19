import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../controllers/locale_cubit.dart';
import 'package:mds/l10n/app_localizations.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      backgroundColor: colors.surfaceContainerLow,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                AppLocalizations.of(context)!.appTitle,
                style: textTheme.titleMedium?.copyWith(
                  letterSpacing: 1.05,
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),
            ),
            // Tonal shift separation rather than a line
            Container(height: 16, color: colors.surface),
            Expanded(
              child: Container(
                color: colors.surface,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  children: [
                    _DrawerItem(
                      icon: Icons.map_outlined,
                      title: AppLocalizations.of(context)!.fieldMap,
                      isActive: true,
                    ),
                    const SizedBox(height: 8),
                    _DrawerItem(
                      icon: Icons.analytics_outlined,
                      title: AppLocalizations.of(context)!.statistics,
                      isActive: false,
                    ),
                    const SizedBox(height: 8),
                    _DrawerItem(
                      icon: Icons.settings_outlined,
                      title: AppLocalizations.of(context)!.operationalSettings,
                      isActive: false,
                    ),
                    const Divider(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.language,
                        style: textTheme.labelSmall?.copyWith(
                          color: colors.primary,
                        ),
                      ),
                    ),
                    _DrawerItem(
                      icon: Icons.language,
                      title:
                          Localizations.localeOf(context).languageCode == 'en'
                          ? AppLocalizations.of(context)!.switchToArabic
                          : AppLocalizations.of(context)!.switchToEnglish,
                      isActive: false,
                      onTap: () {
                        final currentLocale = Localizations.localeOf(context);
                        final newLanguageCode =
                            currentLocale.languageCode == 'en' ? 'ar' : 'en';
                        context.read<LocaleCubit>().changeLanguage(
                          newLanguageCode,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final VoidCallback? onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: isActive ? colors.surfaceContainerHigh : Colors.transparent,
        borderRadius: BorderRadius.circular(4), // ROUND_FOUR
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            if (isActive)
              Container(width: 4, color: colors.secondaryContainer)
            else
              const SizedBox(width: 4),
            Expanded(
              child: ListTile(
                leading: Icon(
                  icon,
                  color: isActive ? colors.primary : colors.onSurfaceVariant,
                ),
                title: Text(
                  title,
                  style: textTheme.labelMedium?.copyWith(
                    letterSpacing: 1.05,
                    color: isActive
                        ? colors.onSurface
                        : colors.onSurfaceVariant,
                  ),
                ),
                onTap: onTap,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                dense: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
