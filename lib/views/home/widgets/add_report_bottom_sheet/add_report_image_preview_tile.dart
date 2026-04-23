import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mds/core/theme/app_theme_tokens.dart';

class AddReportImagePreviewTile extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const AddReportImagePreviewTile({
    super.key,
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
            AspectRatio(
              aspectRatio: 16 / 7,
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
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
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.65),
                    ],
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
