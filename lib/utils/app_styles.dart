import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Headings
  static const TextStyle heading1 = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    height: 1.2,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    height: 1.3,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  // Body text
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    color: AppColors.secondaryText,
    height: 1.6,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    color: AppColors.tertiaryText,
    height: 1.5,
  );
}
