import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get display => GoogleFonts.poppins(
        fontSize: 72,
        fontWeight: FontWeight.w900,
        color: AppColors.primaryText,
        height: 1.1,
        letterSpacing: -1.5,
      );

  static TextStyle get heading1 => GoogleFonts.poppins(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
        height: 1.2,
        letterSpacing: -1.0,
      );

  static TextStyle get heading2 => GoogleFonts.poppins(
        fontSize: 42,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryText,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle get heading3 => GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryText,
        height: 1.3,
      );

  static TextStyle get heading4 => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryText,
        height: 1.4,
      );

  static TextStyle get body1 => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryText,
        height: 1.6,
        letterSpacing: 0.2,
      );

  static TextStyle get body2 => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.tertiaryText,
        height: 1.5,
      );

  static TextStyle get label => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryText,
        letterSpacing: 0.5,
      );

  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.tertiaryText,
        letterSpacing: 0.3,
      );

  static TextStyle get welcome => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryText,
        letterSpacing: 1.0,
      );

  static TextStyle get tagline => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryText,
        height: 1.5,
        letterSpacing: 0.3,
      );
}
