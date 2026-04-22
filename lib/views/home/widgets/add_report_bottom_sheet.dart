import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controllers/report_cubit.dart';
import '../../../controllers/report_state.dart';
import '../../../controllers/map_selection_cubit.dart';
import '../../../controllers/map_selection_state.dart';
import '../../../core/theme/app_theme_tokens.dart';
import 'package:mds/l10n/app_localizations.dart';

class AddReportBottomSheet extends StatefulWidget {
  const AddReportBottomSheet({super.key});

  @override
  State<AddReportBottomSheet> createState() => _AddReportBottomSheetState();
}

class _AddReportBottomSheetState extends State<AddReportBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  final _imagePicker = ImagePicker();
  String? _selectedImagePath;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitReport(BuildContext context, LatLng position) {
    if (_formKey.currentState!.validate()) {
      final coordinates = [position.latitude, position.longitude];

      ReportCubit reportCubit;
      try {
        reportCubit = context.read<ReportCubit>();
      } catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.reportCubitError),
          ),
        );
        return;
      }

      reportCubit.submitVisitorReport(
        fullName: _fullNameController.text,
        phone: _phoneController.text,
        coordinates: coordinates,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        imagePath: _selectedImagePath,
      );

      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (!mounted || pickedImage == null) {
        return;
      }

      setState(() {
        _selectedImagePath = pickedImage.path;
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.errorUnknown),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final selectionState = context.read<MapSelectionCubit>().state;
    final LatLng position = (selectionState is MapLocationSelected)
        ? selectionState.position
        : const LatLng(0, 0);

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHigh,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppThemeTokens.roundEight),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  AppLocalizations.of(context)!.submitHazardReport,
                  style: textTheme.titleMedium?.copyWith(
                    color: colors.error,
                    letterSpacing: 1.05,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppThemeTokens.spacingSm),
                Text(
                  AppLocalizations.of(context)!.linkedLocation(
                    position.latitude.toStringAsFixed(4),
                    position.longitude.toStringAsFixed(4),
                  ),
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    letterSpacing: 1.1,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppThemeTokens.spacingLg),
                TextFormField(
                  controller: _fullNameController,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.fullName,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? AppLocalizations.of(context)!.requiredField
                      : null,
                ),
                const SizedBox(height: AppThemeTokens.spacingMd),
                TextFormField(
                  controller: _phoneController,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface,
                  ),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.phoneNumber,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? AppLocalizations.of(context)!.requiredField
                      : null,
                ),
                const SizedBox(height: AppThemeTokens.spacingMd),
                TextFormField(
                  controller: _notesController,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface,
                  ),
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.notes,
                  ),
                ),
                const SizedBox(height: AppThemeTokens.spacingLg),
                OutlinedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: Text(AppLocalizations.of(context)!.attachImage),
                ),
                if (_selectedImagePath != null) ...[
                  const SizedBox(height: AppThemeTokens.spacingSm),
                  Row(
                    children: [
                      Icon(Icons.check_circle, size: 18, color: colors.primary),
                      const SizedBox(width: AppThemeTokens.spacingSm),
                      Expanded(
                        child: Text(
                          _selectedImagePath!.split(RegExp(r'[\\/]')).last,
                          style: textTheme.labelSmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        tooltip: MaterialLocalizations.of(
                          context,
                        ).deleteButtonTooltip,
                        onPressed: () {
                          setState(() {
                            _selectedImagePath = null;
                          });
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: AppThemeTokens.spacingLg),
                Builder(
                  builder: (context) {
                    // Quick check if the bloc is present
                    try {
                      context.read<ReportCubit>();
                    } catch (_) {
                      // Fallback UI if Bloc isn't connected at the app level yet
                      return _buildSubmitButton(
                        context,
                        false,
                        colors,
                        textTheme,
                        position,
                      );
                    }

                    return BlocConsumer<ReportCubit, ReportState>(
                      listener: (context, state) {
                        final l10n = AppLocalizations.of(context)!;
                        if (state is ReportError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_localizeReportError(l10n, state)),
                              backgroundColor: colors.errorContainer,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is ReportSubmitting;
                        return _buildSubmitButton(
                          context,
                          isLoading,
                          colors,
                          textTheme,
                          position,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(
    BuildContext context,
    bool isLoading,
    ColorScheme colors,
    TextTheme textTheme,
    LatLng position,
  ) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: colors.primaryContainer),
      onPressed: isLoading ? null : () => _submitReport(context, position),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colors.onPrimaryContainer,
                ),
              )
            : Text(
                AppLocalizations.of(context)!.transmitReport,
                style: textTheme.labelMedium?.copyWith(
                  letterSpacing: 1.05,
                  fontWeight: FontWeight.bold,
                  color: colors.onPrimaryContainer,
                ),
              ),
      ),
    );
  }

  String _localizeReportError(AppLocalizations l10n, ReportError error) {
    return switch (error.failure) {
      ReportFailure.api => error.serverMessage ?? l10n.errorGenericServer,
      ReportFailure.offlineQueued => l10n.reportErrorOfflineQueued,
      ReportFailure.unknown => l10n.errorUnknown,
    };
  }
}
