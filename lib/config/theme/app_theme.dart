import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF7CC429);
  static const Color background = Color(0xFFF8F9FB);
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C); 
  static const Color cardBackground = Color(0xFFF3F0F8); 
  static const Color textSecondary = Color(0x8A000000); 
  static const Color textPrimary = Color.fromARGB(195, 22, 22, 22); 
}

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          error: AppColors.error,
        ),
      
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
}