import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get heading1 => GoogleFonts.inter(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get heading2 => GoogleFonts.inter(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get title => GoogleFonts.inter(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get body => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodySecondary => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static TextStyle get buttonText => GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
