import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBackground = Color(0xFF0B0E1D);
  static const Color secondaryBackground = Color(0xFF151930);
  static const Color cardBackground = Color(0xFF1A1F3A);
  static const Color redColor = Color(0xFFF44336);

  static const Color primaryAccent = Color(0xFF5B78FF);
  static const Color secondaryAccent = Color(0xFF9D4EDD);
  static const Color tertiaryAccent = Color(0xFF00D9FF);

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
    colors: [primaryAccent, secondaryAccent],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFF5B78FF), Color(0xFF9D4EDD)],
  );

  // Glow/Shadow colors
  static Color primaryGlow = primaryAccent.withValues(alpha: 0.3);
  static Color secondaryGlow = secondaryAccent.withValues(alpha: 0.3);
}
