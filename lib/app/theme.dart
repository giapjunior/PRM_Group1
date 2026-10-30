import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppColors {
  static const background = Color(0xFF10131A);
  static const surfaceLow = Color(0xFF191C22);
  static const surface = Color(0xFF1D2026);
  static const surfaceHigh = Color(0xFF272A31);
  static const surfaceHighest = Color(0xFF32353C);
  static const input = Color(0xFF0B0E14);
  static const primary = Color(0xFFFFC174);
  static const primaryContainer = Color(0xFFF59E0B);
  static const onPrimary = Color(0xFF472A00);
  static const onPrimaryContainer = Color(0xFF613B00);
  static const text = Color(0xFFE1E2EB);
  static const textMuted = Color(0xFFD8C3AD);
  static const outline = Color(0xFFA08E7A);
  static const outlineVariant = Color(0xFF534434);
  static const green = Color(0xFF56E5A9);
  static const greenDark = Color(0xFF30C88F);
  static const red = Color(0xFFA40217);
  static const pink = Color(0xFFFFB3AD);
}

ThemeData buildAppTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  final vietnameseText = GoogleFonts.beVietnamProTextTheme(base.textTheme);
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.pink,
      surface: AppColors.surface,
      error: Color(0xFFFFB4AB),
      onSurface: AppColors.text,
    ),
    textTheme: vietnameseText.copyWith(
      headlineSmall: GoogleFonts.spaceGrotesk(
        textStyle: vietnameseText.headlineSmall,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        textStyle: vietnameseText.headlineMedium,
      ),
      titleLarge: GoogleFonts.spaceGrotesk(
        textStyle: vietnameseText.titleLarge,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: Color(0x66FFC174),
      selectionHandleColor: AppColors.primary,
    ),
  );
}
