import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        gradient: isEnabled ? AppColors.primaryGradient : null,
        color: isEnabled ? null : AppColors.border,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100.r),
          onTap: isEnabled && !isLoading ? onPressed : null,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Text(
                    text,
                    style: AppTextStyles.buttonText.copyWith(
                      color: isEnabled ? Colors.white : AppColors.textHint,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
