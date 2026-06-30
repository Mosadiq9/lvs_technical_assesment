import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import 'country_flag.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final String flagAsset;
  final bool isSelected;
  final VoidCallback onTap;

  // Customizable dimension parameters to easily adjust chip styling
  final double height;
  final double horizontalPadding;
  final double borderRadius;
  final double borderWidth;
  final double flagWidth;
  final double flagHeight;
  final double flagSpacing;
  final double fontSize;

  const CategoryChip({
    super.key,
    required this.label,
    required this.flagAsset,
    required this.isSelected,
    required this.onTap,
    this.height = 34.0,              // Chip overall height
    this.horizontalPadding = 14.0,   // Internal left & right padding inside chip
    this.borderRadius = 100.0,       // Corner radius (pill shape)
    this.borderWidth = 1.0,          // Border thickness
    this.flagWidth = 16.0,           // Flag icon width
    this.flagHeight = 12.0,          // Flag icon height
    this.flagSpacing = 6.0,          // Space between flag and text
    this.fontSize = 13.0,            // Label font size
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.12) : Colors.white,
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFE0E0E0),
            width: borderWidth,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CountryFlag(
              countryCodeOrPath: flagAsset,
              width: flagWidth.w,
              height: flagHeight.h,
            ),
            SizedBox(width: flagSpacing.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: fontSize.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : const Color(0xFF616161),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
