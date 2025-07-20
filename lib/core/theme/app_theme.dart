import 'package:flutter/material.dart';
import 'app_colors.dart';

/// AppTheme — тема оформления приложения
class AppTheme {
  ///
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.purple500,
    colorScheme: const ColorScheme.light(
      primary: AppColors.purple500,
      secondary: AppColors.success500,
      error: AppColors.error500,
      surface: AppColors.grey25,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onError: AppColors.white,
      onSurface: AppColors.grey900,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.grey900),
      bodyMedium: TextStyle(color: AppColors.grey700),
      bodySmall: TextStyle(color: AppColors.grey500),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.grey900,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: AppColors.grey700),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.purple500,
      foregroundColor: AppColors.white,
    ),
  );

  ///
  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.grey900,
    primaryColor: AppColors.purple300,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.purple300,
      secondary: AppColors.success300,
      error: AppColors.error400,
      surface: AppColors.grey800,
      onPrimary: AppColors.grey900,
      onSecondary: AppColors.grey900,
      onError: AppColors.grey900,
      onSurface: AppColors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.white),
      bodyMedium: TextStyle(color: AppColors.grey100),
      bodySmall: TextStyle(color: AppColors.grey300),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.grey800,
      foregroundColor: AppColors.white,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: AppColors.grey100),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.purple300,
      foregroundColor: AppColors.grey900,
    ),
  );

  const AppTheme._(); // приватный конструктор для предотвращения создания экземпляров
}
