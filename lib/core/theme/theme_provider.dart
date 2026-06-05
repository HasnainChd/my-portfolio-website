import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeProvider() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);
    if (savedTheme != null) {
      _themeMode = savedTheme == 'light' ? ThemeMode.light : ThemeMode.dark;
      notifyListeners();
    }
  }

  Future<void> toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _themeKey, _themeMode == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }

  ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF0B0F1A),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF7C5CFC),
        secondary: Color(0xFFA78BFA),
        surface: Color(0xFF0E1420),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFFF0F4FF),
      ),
      cardColor: const Color(0xFF0E1420),
      dividerColor: const Color(0xFF1E2A3A),
      textTheme:
          _buildTextTheme(const Color(0xFFF0F4FF), const Color(0xFF7A8BA0)),
    );
  }

  ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF7F8FC),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF7C5CFC),
        secondary: Color(0xFFA78BFA),
        surface: Color(0xFFFFFFFF),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF0D1526),
      ),
      cardColor: const Color(0xFFFFFFFF),
      dividerColor: const Color(0xFFE2E8F0),
      textTheme:
          _buildTextTheme(const Color(0xFF0D1526), const Color(0xFF64748B)),
    );
  }

  TextTheme _buildTextTheme(Color foreground, Color muted) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 72,
        fontWeight: FontWeight.w900,
        color: foreground,
        height: 1.1,
        letterSpacing: -1.5,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 56,
        fontWeight: FontWeight.w800,
        color: foreground,
        height: 1.2,
        letterSpacing: -1.0,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 42,
        fontWeight: FontWeight.w700,
        color: foreground,
        height: 1.2,
        letterSpacing: -0.5,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: foreground,
        height: 1.3,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: foreground,
        height: 1.4,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: muted,
        height: 1.6,
        letterSpacing: 0.2,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: muted,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: muted,
        letterSpacing: 0.5,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: foreground,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: muted,
        letterSpacing: 0.3,
      ),
    );
  }
}
