import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle display = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.w900,
    color: AppColors.primaryText,
    height: 1.1,
    letterSpacing: -1.5,
  );

  static const TextStyle heading1 = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryText,
    height: 1.2,
    letterSpacing: -1.0,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
    height: 1.3,
  );

  static const TextStyle heading4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
    height: 1.4,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
    height: 1.6,
    letterSpacing: 0.2,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.tertiaryText,
    height: 1.5,
  );

  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
    letterSpacing: 0.5,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.tertiaryText,
    letterSpacing: 0.3,
  );

  static const TextStyle welcome = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
    letterSpacing: 1.0,
  );

  static const TextStyle tagline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
    height: 1.5,
    letterSpacing: 0.3,
  );
}
