import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_palette.dart';

class AppTheme {
  AppTheme._();

  // Light Theme
  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPalette.whiteColor,

    // Color Scheme
    colorScheme: ColorScheme.fromSeed(
      primary: AppPalette.blackColor,
      secondary: AppPalette.whiteColor,
      seedColor: AppPalette.blackColor,
      brightness: Brightness.light,
    ),

    // App Bar
    appBarTheme: AppBarTheme(
      backgroundColor: AppPalette.whiteColor,
      foregroundColor: AppPalette.blackColor,
      elevation: 0,
    ),

    // Snack Bar
    snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(color: Colors.white),
    ),

    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.blackColor,
        foregroundColor: AppPalette.whiteColor,
        shape: ContinuousRectangleBorder(),
        minimumSize: Size(1000, 55),
        alignment: Alignment.center,
      ),
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppPalette.whiteColor,
      selectedItemColor: AppPalette.blackColor,
      unselectedItemColor: AppPalette.greyColor,
      type: BottomNavigationBarType.fixed,
    ),
  );

  // Dark Theme
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPalette.blackColor,
    primaryColor: AppPalette.whiteColor,

    //Color Scheme
    colorScheme: ColorScheme.fromSeed(
      primary: AppPalette.whiteColor,
      secondary: AppPalette.blackColor,
      seedColor: AppPalette.whiteColor,
      brightness: Brightness.dark,
    ),

    // App Bar
    appBarTheme: AppBarTheme(
      backgroundColor: AppPalette.blackColor,
      foregroundColor: AppPalette.whiteColor,
      elevation: 0,
    ),

    // Snack Bar
    snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(color: Colors.white),
    ),

    // Text Form Field
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      constraints: BoxConstraints(minWidth: 10000, minHeight: 55),
    ),

    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.whiteColor,
        foregroundColor: AppPalette.blackColor,
        shape: ContinuousRectangleBorder(),
        minimumSize: Size(10000, 55),
        alignment: Alignment.center,
      ),
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppPalette.blackColor,
      selectedItemColor: AppPalette.whiteColor,
      unselectedItemColor: AppPalette.greyColor,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
