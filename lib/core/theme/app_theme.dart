import 'package:flutter/material.dart';

/// Global App Theme Configuration
/// অ্যাপের রেসপনসিভ এবং সুন্দর Material 3 কালার প্যালেট থিম এখানে ডিফাইন করা হয়েছে।
class AppTheme {
  AppTheme._();

  static const Color primaryColor = Colors.deepPurple;
  static const Color accentColor = Colors.amber;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: accentColor,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        centerTitle: false,
      ),
      scaffoldBackgroundColor: const Color(0xFFF7F8FA),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
