import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mds/controllers/local_controller/locale_cubit.dart';
import 'package:mds/l10n/app_localizations.dart';

class SettingsLanguageSection extends StatelessWidget {
  const SettingsLanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = Localizations.localeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            l10n.language,
            style: textTheme.labelSmall?.copyWith(
              color: colors.primary,
              letterSpacing: 1.1,
            ),
          ),
        ),
        Card(
          color: colors.surfaceContainerLow,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              _LanguageOption(
                title: 'English',
                isSelected: currentLocale.languageCode == 'en',
                onTap: () => context.read<LocaleCubit>().changeLanguage('en'),
              ),
              _LanguageOption(
                title: 'العربية',
                isSelected: currentLocale.languageCode == 'ar',
                onTap: () => context.read<LocaleCubit>().changeLanguage('ar'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      title: Text(
        title,
        style: textTheme.bodyLarge?.copyWith(
          color: isSelected ? colors.onSurface : colors.onSurfaceVariant,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: colors.secondary)
          : null,
      onTap: onTap,
    );
  }
}
