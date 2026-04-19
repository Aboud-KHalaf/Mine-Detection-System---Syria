import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_theme_tokens.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData dark() {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: Color(0xFF2B0F0C),
      primaryContainer: Color(0xFF5A231D),
      onPrimaryContainer: Color(0xFFFFDFDB),
      secondary: AppColors.secondary,
      onSecondary: Color(0xFF0F2B0E),
      secondaryContainer: Color(0xFF1F4920),
      onSecondaryContainer: Color(0xFFD8FFD5),
      tertiary: AppColors.tertiary,
      onTertiary: Color(0xFF2B1A00),
      tertiaryContainer: Color(0xFF5F3E13),
      onTertiaryContainer: Color(0xFFFFE1BE),
      error: AppColors.error,
      onError: Color(0xFF310010),
      errorContainer: Color(0xFF5F1F30),
      onErrorContainer: Color(0xFFFFD9E2),
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: AppColors.outlineVariant,
      outlineVariant: AppColors.outlineVariant,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Color(0xFFE6E1E0),
      onInverseSurface: Color(0xFF23201F),
      inversePrimary: Color(0xFF8D4B44),
      surfaceContainerLowest: AppColors.surfaceContainerLowest,
      surfaceContainerLow: AppColors.surfaceContainerLow,
      surfaceContainer: AppColors.surfaceContainer,
      surfaceContainerHigh: AppColors.surfaceContainerHigh,
      surfaceContainerHighest: AppColors.surfaceContainerHighest,
      surfaceBright: Color(0xFF3A3838),
      surfaceDim: Color(0xFF121111),
    );

    final textTheme = AppTypography.textTheme(colorScheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surfaceContainerLow,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerHigh,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeTokens.roundEight),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeTokens.roundFour),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeTokens.roundFour),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.onSurface,
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(
              alpha: AppThemeTokens.ghostBorderOpacity,
            ),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppThemeTokens.roundFour),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerLowest,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.outlineVariant.withValues(
              alpha: AppThemeTokens.ghostBorderOpacity,
            ),
          ),
          borderRadius: BorderRadius.circular(AppThemeTokens.roundFour),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.tertiary.withValues(alpha: 0.5),
          ),
          borderRadius: BorderRadius.circular(AppThemeTokens.roundFour),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Colors.transparent,
        space: 0,
        thickness: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        contentTextStyle: textTheme.bodyMedium,
      ),
    );
  }
}
