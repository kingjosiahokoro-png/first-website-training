import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Strata Typography System
/// Built on Hanken Grotesk with Apple SF Pro micro-tracking calibrations.
class AppTypography {
  static TextStyle get displayLg => GoogleFonts.hankenGrotesk(
        fontSize: 48,
        fontWeight: FontWeight.w600,
        letterSpacing: -1.44,
        color: AppColors.onSurface,
        height: 52 / 48,
      );

  static TextStyle get displayLgMobile => GoogleFonts.hankenGrotesk(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.9,
        color: AppColors.onSurface,
        height: 40 / 36,
      );

  static TextStyle get headlineLg => GoogleFonts.hankenGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.64,
        color: AppColors.onSurface,
        height: 38 / 32,
      );

  static TextStyle get headlineLgMobile => GoogleFonts.hankenGrotesk(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.39,
        color: AppColors.onSurface,
        height: 32 / 26,
      );

  static TextStyle get headlineMd => GoogleFonts.hankenGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.33,
        color: AppColors.onSurface,
        height: 28 / 22,
      );

  static TextStyle get titleLg => GoogleFonts.hankenGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.18,
        color: AppColors.onSurface,
        height: 24 / 18,
      );

  static TextStyle get titleMd => GoogleFonts.hankenGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.08,
        color: AppColors.onSurface,
        height: 22 / 16,
      );

  static TextStyle get bodyLg => GoogleFonts.hankenGrotesk(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.onSurface,
        height: 24 / 16,
      );

  static TextStyle get bodyMd => GoogleFonts.hankenGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.onSurfaceVariant,
        height: 20 / 14,
      );

  static TextStyle get labelMd => GoogleFonts.hankenGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.24,
        color: AppColors.onSurfaceVariant,
        height: 16 / 12,
      );

  static TextStyle get labelSm => GoogleFonts.hankenGrotesk(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.6,
        color: AppColors.onSurfaceVariant,
        height: 14 / 10,
      );

  static TextStyle get luxuryTracking => GoogleFonts.hankenGrotesk(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 2.2,
        color: AppColors.onSurfaceVariant,
      );

  static TextStyle get airportCode => GoogleFonts.hankenGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: AppColors.onSurface,
      );
}

