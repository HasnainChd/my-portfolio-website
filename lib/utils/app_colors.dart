import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBackground = Color(0xFF0B0E1D);
  static const Color secondaryBackground = Color(0xFF151930);
  static const Color cardBackground = Color(0xFF1A1F3A);
  static const Color redColor = Color(0xFFF44336);

  /// Bold electric blue → cyan gradient anchors (navy base unchanged).
  static const Color primaryAccent = Color(0xFF0099FF);
  static const Color secondaryAccent = Color(0xFF00E5FF);
  static const Color tertiaryAccent = Color(0xFF5CE1FF);

  // Text colors
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFB8C5D6);
  static const Color tertiaryText = Color(0xFF8892A6);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0B0E1D),
      Color(0xFF1A1F3A),
      Color(0xFF0B0E1D),
    ],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryAccent, secondaryAccent],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryAccent, secondaryAccent],
  );

  // Glow/Shadow colors
  static Color primaryGlow = primaryAccent.withValues(alpha: 0.35);
  static Color secondaryGlow = secondaryAccent.withValues(alpha: 0.35);

  // Category background colors
  static const Color mobileCategory = Color(0xFF2196F3);
  static const Color backendCategory = Color(0xFF4CAF50);
  static const Color stateCategory = Color(0xFF9C27B0);
  static const Color testingCategory = Color(0xFFFF9800);
  static const Color deploymentCategory = Color(0xFF00BCD4);

  static Color mobileCategoryTint = mobileCategory.withValues(alpha: 0.1);
  static Color backendCategoryTint = backendCategory.withValues(alpha: 0.1);
  static Color stateCategoryTint = stateCategory.withValues(alpha: 0.1);
  static Color testingCategoryTint = testingCategory.withValues(alpha: 0.1);
  static Color deploymentCategoryTint =
      deploymentCategory.withValues(alpha: 0.1);

  // Project gradient colors
  static const Color tealpotStart = Color(0xFF0F2027);
  static const Color tealpotMiddle = Color(0xFF203A43);
  static const Color tealpotEnd = Color(0xFF2C5364);

  static const Color serviceProStart = Color(0xFF1a1a2e);
  static const Color serviceProMiddle = Color(0xFF16213e);
  static const Color serviceProEnd = Color(0xFF0f3460);
}
