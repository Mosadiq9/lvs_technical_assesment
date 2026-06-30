import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import 'app_logo.dart';

class TopAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onSearchTap;
  final VoidCallback? onNotificationTap;

  const TopAppBar({
    super.key,
    required this.title,
    this.onSearchTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Alive logo on left
          Row(
            children: [
              const AppLogo(size: 36),
              SizedBox(width: 8.w),
              Text(
                'Alive',
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          
          // Icons on right
          Row(
            children: [
              // Notification icon with red badge
              GestureDetector(
                onTap: onNotificationTap,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.textPrimary,
                      size: 26.w,
                    ),
                    Positioned(
                      right: 2.w,
                      top: 2.h,
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              
              // Green circular wallet / profile icon
              GestureDetector(
                onTap: onNotificationTap,
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Colors.white,
                    size: 20.w,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
