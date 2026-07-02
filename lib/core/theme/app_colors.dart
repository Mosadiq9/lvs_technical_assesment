import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF7DD500);
  static const Color primaryDark = Color(0xFF1CB400);
  static const Color background = Colors.white;
  static const Color surface = Colors.white;

  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  static const Color border = Color(0xFFEEEEEE);
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
