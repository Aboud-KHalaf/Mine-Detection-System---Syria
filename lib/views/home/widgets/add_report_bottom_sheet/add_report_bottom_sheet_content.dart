import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:mds/core/theme/app_theme_tokens.dart';
import 'package:mds/l10n/app_localizations.dart';

import 'add_report_form_fields.dart';
import 'add_report_header.dart';
import 'add_report_image_section.dart';
import 'add_report_submit_button.dart';

class AddReportBottomSheetContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final LatLng position;
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController notesController;
  final String? selectedImagePath;
  final VoidCallback onPickImage;
  final VoidCallback onOpenImagePreview;
  final VoidCallback onRemoveImage;
  final VoidCallback onSubmit;

  const AddReportBottomSheetContent({
    super.key,
    required this.formKey,
    required this.position,
    required this.fullNameController,
    required this.phoneController,
    required this.notesController,
    required this.selectedImagePath,
    required this.onPickImage,
    required this.onOpenImagePreview,
    required this.onRemoveImage,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerHigh,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppThemeTokens.roundEight),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AddReportHeader(position: position),
                const SizedBox(height: AppThemeTokens.spacingLg),
                AddReportFormFields(
                  fullNameController: fullNameController,
                  phoneController: phoneController,
                  notesController: notesController,
                  requiredFieldValidator: (value) =>
                      value == null || value.isEmpty
                      ? AppLocalizations.of(context)!.requiredField
                      : null,
                ),
                const SizedBox(height: AppThemeTokens.spacingLg),
                AddReportImageSection(
                  selectedImagePath: selectedImagePath,
                  onPickImage: onPickImage,
                  onOpenImagePreview: onOpenImagePreview,
                  onRemoveImage: onRemoveImage,
                ),
                const SizedBox(height: AppThemeTokens.spacingLg),
                AddReportSubmitButton(onSubmit: onSubmit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
