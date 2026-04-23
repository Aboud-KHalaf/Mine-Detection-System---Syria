import 'package:flutter/material.dart';
import 'package:mds/core/theme/app_theme_tokens.dart';
import 'package:mds/l10n/app_localizations.dart';

import 'add_report_image_preview_tile.dart';

class AddReportImageSection extends StatelessWidget {
  final String? selectedImagePath;
  final VoidCallback onPickImage;
  final VoidCallback onOpenImagePreview;
  final VoidCallback onRemoveImage;

  const AddReportImageSection({
    super.key,
    required this.selectedImagePath,
    required this.onPickImage,
    required this.onOpenImagePreview,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton.icon(
          onPressed: onPickImage,
          icon: const Icon(Icons.camera_alt_outlined),
          label: Text(AppLocalizations.of(context)!.attachImage),
        ),
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
          child: selectedImagePath != null
              ? Padding(
                  key: const ValueKey('image-preview'),
                  padding: const EdgeInsets.only(top: AppThemeTokens.spacingSm),
                  child: AddReportImagePreviewTile(
                    imagePath: selectedImagePath!,
                    onTap: onOpenImagePreview,
                    onRemove: onRemoveImage,
                  ),
                )
              : const SizedBox.shrink(key: ValueKey('no-image')),
        ),
      ],
    );
  }
}
