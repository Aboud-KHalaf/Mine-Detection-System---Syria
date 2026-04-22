import 'dart:io';
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

class _AddReportBottomSheetState extends State<AddReportBottomSheet>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  final _imagePicker = ImagePicker();
  String? _selectedImagePath;

  late final AnimationController _animController;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    _animController.dispose();
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

      if (!mounted || pickedImage == null) return;

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

  void _showImagePreview(BuildContext context) {
    if (_selectedImagePath == null) return;
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(_selectedImagePath!),
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final selectionState = context.read<MapSelectionCubit>().state;
    final LatLng position = (selectionState is MapLocationSelected)
        ? selectionState.position
        : const LatLng(0, 0);

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Container(
          decoration: BoxDecoration(
            color: colors.surfaceContainerHigh,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppThemeTokens.roundEight),
            ),
          ),
          // Padding accounts for keyboard insets
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Drag handle
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

                    // Title
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

                    // Location subtitle
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

                    // Full name
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

                    // Phone
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

                    // Notes
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

                    // Image picker button
                    OutlinedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: Text(AppLocalizations.of(context)!.attachImage),
                    ),

                    // Image preview (animated appearance)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      switchInCurve: Curves.easeOutBack,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.2),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      ),
                      child: _selectedImagePath != null
                          ? Padding(
                              key: const ValueKey('image-preview'),
                              padding: const EdgeInsets.only(
                                top: AppThemeTokens.spacingSm,
                              ),
                              child: _ImagePreviewTile(
                                imagePath: _selectedImagePath!,
                                onTap: () => _showImagePreview(context),
                                onRemove: () =>
                                    setState(() => _selectedImagePath = null),
                              ),
                            )
                          : const SizedBox.shrink(
                              key: ValueKey('no-image'),
                            ),
                    ),

                    const SizedBox(height: AppThemeTokens.spacingLg),

                    // Submit button
                    Builder(
                      builder: (context) {
                        try {
                          context.read<ReportCubit>();
                        } catch (_) {
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
                                  content: Text(
                                    _localizeReportError(l10n, state),
                                  ),
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

// ---------------------------------------------------------------------------
// Private image preview tile
// ---------------------------------------------------------------------------

class _ImagePreviewTile extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _ImagePreviewTile({
    required this.imagePath,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final fileName = imagePath.split(RegExp(r'[\\/]')).last;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppThemeTokens.roundEight),
        child: Stack(
          children: [
            // Thumbnail
            AspectRatio(
              aspectRatio: 16 / 7,
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),

            // Dark gradient overlay at bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withValues(alpha: 0.65)],
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.image_outlined,
                      size: 14,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        fileName,
                        style: textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.zoom_in_rounded,
                      size: 14,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
            ),

            // Remove button (top-right)
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: onRemove,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: colors.errorContainer,
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: colors.onErrorContainer,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
