import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_assets.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60.h, left: 24.w, right: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset(
              AppAssets.logo,
              width: 65.w,
              height: 65.w,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const _AliveLogoBadge();
              },
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Welcome back! 👋',
            style: GoogleFonts.inter(
              fontSize: 26.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E1E1E),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Text(
            'Sign in to continue your live streaming journey.',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF616161),
              height: 1.15,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _AliveLogoBadge extends StatelessWidget {
  const _AliveLogoBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55.w,
      height: 55.w,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD2F500), Color(0xFF1FB200)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF53C800).withValues(alpha: 0.10),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Alive',
            style: GoogleFonts.outfit(
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.0,
              letterSpacing: -0.4,
            ),
          ),
          SizedBox(height: 1.5.h),
          Icon(Icons.videocam_rounded, color: Colors.white, size: 14.w),
        ],
      ),
    );
  }
}
