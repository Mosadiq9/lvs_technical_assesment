import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24.w,
                height: 24.w,
                child: const Icon(Icons.account_circle, color: Colors.blue),
              ),
              SizedBox(width: 12.w),
              Text(
                text,
                style: AppTextStyles.title.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
