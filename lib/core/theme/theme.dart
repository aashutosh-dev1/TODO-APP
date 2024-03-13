import 'package:flutter/material.dart';
import 'package:tasker/core/theme/colors.dart';

/// Theme Data
ThemeData themeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  useMaterial3: false,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 34,
      letterSpacing: 0.136,
      color: primaryColor,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20,
      height: 1.5,
      letterSpacing: 0.136,
      color: primaryColor,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: primaryColor,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 15,
      color: primaryColor,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 26,
      height: 1.5,
      color: primaryColor,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.5,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.5,
      color: primaryColor,
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.5,
      color: primaryColor,
    ),
  ),
  colorScheme: ColorScheme(
    background: backgroundColor,
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: primaryColor.withOpacity(0.5),
    secondary: secondaryColor,
    onSecondary: secondaryColor.withOpacity(0.5),
    error: Colors.red,
    onError: Colors.red,
    onBackground: const Color(0xffEDEFF3),
    surface: containerColor,
    onSurface: containerColorDark,
  ),
);
