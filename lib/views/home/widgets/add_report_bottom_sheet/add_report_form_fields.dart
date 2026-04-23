import 'package:flutter/material.dart';
import 'package:mds/core/theme/app_theme_tokens.dart';
import 'package:mds/l10n/app_localizations.dart';

class AddReportFormFields extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController notesController;
  final FormFieldValidator<String> requiredFieldValidator;

  const AddReportFormFields({
    super.key,
    required this.fullNameController,
    required this.phoneController,
    required this.notesController,
    required this.requiredFieldValidator,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        TextFormField(
          controller: fullNameController,
          style: textTheme.bodyMedium?.copyWith(color: colors.onSurface),
          decoration: InputDecoration(hintText: l10n.fullName),
          validator: requiredFieldValidator,
        ),
        const SizedBox(height: AppThemeTokens.spacingMd),
        TextFormField(
          controller: phoneController,
          style: textTheme.bodyMedium?.copyWith(color: colors.onSurface),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(hintText: l10n.phoneNumber),
          validator: requiredFieldValidator,
        ),
        const SizedBox(height: AppThemeTokens.spacingMd),
        TextFormField(
          controller: notesController,
          style: textTheme.bodyMedium?.copyWith(color: colors.onSurface),
          maxLines: 3,
          decoration: InputDecoration(hintText: l10n.notes),
        ),
      ],
    );
  }
}
