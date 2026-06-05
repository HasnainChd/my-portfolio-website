import 'package:flutter/material.dart';

class AppColors {
  // ─── DARK MODE ───────────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0B0F1A);
  static const Color darkSurface = Color(0xFF0E1420);
  static const Color darkCard = Color(0xFF111827);
  static const Color darkBorder = Color(0xFF1E2A3A);
  static const Color darkForeground = Color(0xFFF0F4FF);
  static const Color darkMutedText = Color(0xFF7A8BA0);

  // ─── LIGHT MODE ──────────────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFF7F8FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightForeground = Color(0xFF0D1526);
  static const Color lightMutedText = Color(0xFF64748B);

  // ─── ACCENT (same in both modes) ─────────────────────────────────────────
  static const Color primaryAccent = Color(0xFF7C5CFC);
  static const Color accentLight = Color(0xFFA78BFA);
  static const Color primaryGlow = Color(0x337C5CFC);

  // ─── GRADIENTS ───────────────────────────────────────────────────────────
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryAccent, accentLight],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryAccent, accentLight],
  );

  // ─── CATEGORY COLORS (skills) ─────────────────────────────────────────────
  static const Color mobileCategory = Color(0xFF2196F3);
  static const Color backendCategory = Color(0xFF4CAF50);
  static const Color stateCategory = Color(0xFF9C27B0);
  static const Color testingCategory = Color(0xFFFF9800);
  static const Color deploymentCategory = Color(0xFF00BCD4);

  static Color mobileCategoryTint = mobileCategory.withValues(alpha: 0.12);
  static Color backendCategoryTint = backendCategory.withValues(alpha: 0.12);
  static Color stateCategoryTint = stateCategory.withValues(alpha: 0.12);
  static Color testingCategoryTint = testingCategory.withValues(alpha: 0.12);
  static Color deploymentCategoryTint =
      deploymentCategory.withValues(alpha: 0.12);

  // ─── PROJECT HEADER GRADIENTS ─────────────────────────────────────────────
  static const Color tealpotStart = Color(0xFF0F2027);
  static const Color tealpotMiddle = Color(0xFF203A43);
  static const Color tealpotEnd = Color(0xFF2C5364);
  static const Color serviceProStart = Color(0xFF1a1a2e);
  static const Color serviceProMiddle = Color(0xFF16213e);
  static const Color serviceProEnd = Color(0xFF0f3460);
  static const Color newLeafStart = Color(0xFF134E4A);
  static const Color newLeafMiddle = Color(0xFF065F46);
  static const Color newLeafEnd = Color(0xFF064E3B);

  // ─── CONTEXT-AWARE HELPERS ────────────────────────────────────────────────
  // Use these in every widget instead of hardcoded dark values.
  static bool _isDark(BuildContext ctx) =>
      Theme.of(ctx).brightness == Brightness.dark;

  static Color background(BuildContext ctx) =>
      _isDark(ctx) ? darkBackground : lightBackground;

  static Color surface(BuildContext ctx) =>
      _isDark(ctx) ? darkSurface : lightSurface;

  static Color card(BuildContext ctx) => _isDark(ctx) ? darkCard : lightCard;

  static Color border(BuildContext ctx) =>
      _isDark(ctx) ? darkBorder : lightBorder;

  static Color foreground(BuildContext ctx) =>
      _isDark(ctx) ? darkForeground : lightForeground;

  static Color mutedText(BuildContext ctx) =>
      _isDark(ctx) ? darkMutedText : lightMutedText;
}
