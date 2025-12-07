import 'package:flutter/material.dart';

class AppColors {
  // Background colors
  static const Color primaryBackground = Color(0xFF0A0E21);
  static const Color secondaryBackground = Color(0xFF1D1E33);
  static const Color cardBackground = Color(0xFF111328);

  // Accent colors
  static const Color primaryAccent = Color(0xFF00D9FF);
  static const Color secondaryAccent = Color(0xFF6C63FF);

  // Text colors
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFB0B0B0);
  static const Color tertiaryText = Color(0xFF808080);

  // Gradient
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBackground, secondaryBackground],
  );
}
