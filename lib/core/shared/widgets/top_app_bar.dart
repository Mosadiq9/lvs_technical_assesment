import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          // Alive gradient logo badge on left matching login screen
          const AppLogo(size: 42),
          
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
                      CupertinoIcons.bell,
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
                    CupertinoIcons.creditcard,
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
