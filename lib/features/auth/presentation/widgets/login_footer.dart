import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_assets.dart';

class LoginFooter extends StatelessWidget {
  final VoidCallback onGooglePressed;
  final VoidCallback? onFacebookPressed;

  const LoginFooter({
    super.key,
    required this.onGooglePressed,
    this.onFacebookPressed,
  });

  @override
  Widget build(BuildContext context) {
    // =========================================================================
    // 🎛️ MANUAL CONTROLS: ADJUST THESE TO LIFT & POSITION THE BOTTOM WAVE
    // =========================================================================
    // 1. GREEN WAVE VERTICAL LIFT:
    // A negative number lifts the green wave higher up towards the Login button.
    // Try changing -70.h to -100.h (higher up) or -30.h (lower down).
    final double waveLiftOffset = -10.h;

    // 2. TOP SPACE ABOVE SOCIAL LOGIN SECTION:
    // Controls how far below the login form the divider & Google button sit.
    final double socialSectionTopPadding = 80.h;
    // =========================================================================

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // 1. Background image replacing green wave, manually lifted up
        Positioned(
          top: waveLiftOffset,
          left: 0,
          right: 0,
          bottom: 0,
          child: Image.asset(
            AppAssets.loginBg,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Uses manual control above
              SizedBox(height: socialSectionTopPadding),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.white.withValues(alpha: 0.35),
                      thickness: 1.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      'or continue with',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.white.withValues(alpha: 0.35),
                      thickness: 1.h,
                    ),
                  ),
                ],
              ),
              // ─── CONTROL 2: GAP BETWEEN DIVIDER & GOOGLE BUTTON ───
              // Increase this (e.g. from 16.h to 40.h or 50.h) to push ONLY the Google button further down below the divider!
                SizedBox(height: 16.h),
              // 5. Reduce Google button height slightly (42.h)
              _SocialPillButton(
                onTap: onGooglePressed,
                iconWidget: Image.asset(
                  'assets/icons/google.png',
                  width: 18.w,
                  height: 18.w,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.g_mobiledata_rounded,
                    color: Colors.blue.shade700,
                    size: 24.w,
                  ),
                ),
                label: 'Continue with Google',
              ),
              
              
              SizedBox(height: 16.h),
              // 5. Reduce Google button height slightly (42.h)
              _SocialPillButton(
                onTap: onGooglePressed,
                iconWidget: Image.asset(
                  'assets/icons/google.png',
                  width: 18.w,
                  height: 18.w,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.g_mobiledata_rounded,
                    color: Colors.blue.shade700,
                    size: 24.w,
                  ),
                ),
                label: 'Continue with Google',
              ),
              // 6. Facebook Login button removed completely per technical assessment requirement
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      color: Colors.white.withValues(alpha: 0.90),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: const Color(0xFFEAFF00),
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFFEAFF00),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ],
    );
  }
}

class _SocialPillButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget iconWidget;
  final String label;

  const _SocialPillButton({
    required this.onTap,
    required this.iconWidget,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E1E1E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
