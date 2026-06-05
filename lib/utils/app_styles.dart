import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  // Display/Headings: Outfit (weights: 700, 800, 900)
  static TextStyle get display => GoogleFonts.outfit(
        fontSize: 72,
        fontWeight: FontWeight.w900,
        color: AppColors.darkForeground,
        height: 1.1,
        letterSpacing: -1.5,
      );

  static TextStyle get heading1 => GoogleFonts.outfit(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        color: AppColors.darkForeground,
        height: 1.2,
        letterSpacing: -1.0,
      );

  static TextStyle get heading2 => GoogleFonts.outfit(
        fontSize: 42,
        fontWeight: FontWeight.w700,
        color: AppColors.darkForeground,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle get heading3 => GoogleFonts.outfit(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.darkForeground,
        height: 1.3,
      );

  static TextStyle get heading4 => GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.darkForeground,
        height: 1.4,
      );

  // Body: Plus Jakarta Sans (weights: 400, 500, 600)
  static TextStyle get body1 => GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.darkMutedText,
        height: 1.6,
        letterSpacing: 0.2,
      );

  static TextStyle get body2 => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.darkMutedText,
        height: 1.5,
      );

  static TextStyle get label => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.darkMutedText,
        letterSpacing: 0.5,
      );

  static TextStyle get caption => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.darkMutedText,
        letterSpacing: 0.3,
      );

  static TextStyle get welcome => GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.darkMutedText,
        letterSpacing: 1.0,
      );

  static TextStyle get tagline => GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.darkMutedText,
        height: 1.5,
        letterSpacing: 0.3,
      );
}
