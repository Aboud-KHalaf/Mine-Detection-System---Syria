import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTypography {
  static TextTheme textTheme(ColorScheme colorScheme) {
    final inter = GoogleFonts.interTextTheme();
    final cairoFamily = GoogleFonts.cairo().fontFamily;

    TextStyle withFallback(TextStyle? style) {
      return (style ?? const TextStyle()).copyWith(
        color: colorScheme.onSurface,
        fontFamilyFallback: [if (cairoFamily != null) cairoFamily],
      );
    }

    return inter.copyWith(
      displayLarge: withFallback(inter.displayLarge),
      displayMedium: withFallback(inter.displayMedium),
      headlineMedium: withFallback(inter.headlineMedium),
      headlineSmall: withFallback(inter.headlineSmall),
      titleMedium: withFallback(inter.titleMedium),
      bodyMedium: withFallback(inter.bodyMedium),
      labelMedium: withFallback(inter.labelMedium).copyWith(
        letterSpacing: 0.8,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: withFallback(inter.labelSmall).copyWith(
        letterSpacing: 0.8,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
