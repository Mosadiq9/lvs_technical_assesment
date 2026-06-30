import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // 1. Two overlapping Bézier wave layers filling 100% to bottom
        Positioned.fill(
          child: CustomPaint(
            painter: _GreenWavesPainter(),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ─── CONTROL 1: TOP SPACE INSIDE GREEN WAVE ───
              // Increase this (e.g. from 28.h to 60.h or 80.h) to push the ENTIRE social section (divider + button) lower down toward the bottom!
              SizedBox(height: 60.h),
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
              // 6. Facebook Login button removed completely per technical assessment requirement
              SizedBox(height: 18.h),
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
              SizedBox(height: 30.h),
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

// ─── MASTER GUIDE: HOW TO CONTROL EVERY DETAIL OF THE GREEN WAVES ───
class _GreenWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // -------------------------------------------------------------------------
    // LAYER 1: BACK WAVE (Dark Green #0A6800)
    // -------------------------------------------------------------------------
    final Path backPath = Path();
    
    // 1. START POINT (Left edge of screen): (x = 0, y = 10)
    // Increase `10` (e.g. to 30) to push the left starting point lower down!
    backPath.moveTo(0, 10);

    // 2. CUBIC BÉZIER CURVE TO RIGHT EDGE:
    // cubicTo(ControlPoint1_X, ControlPoint1_Y, ControlPoint2_X, ControlPoint2_Y, EndPoint_X, EndPoint_Y)
    // - Control Point 1 (size.width * 0.32, 0): Pulls the left 1/3 curve upward toward y = 0.
    // - Control Point 2 (size.width * 0.68, 38): Dips the right 2/3 curve downward toward y = 38.
    // - End Point (size.width, 6): Meets the right screen edge at y = 6.
    backPath.cubicTo(
      size.width * 0.32, 0,
      size.width * 0.68, 38,
      size.width, 6,
    );
    backPath.lineTo(size.width, size.height); // Draw down to bottom right corner
    backPath.lineTo(0, size.height);          // Draw across to bottom left corner
    backPath.close();                         // Fill the shape

    final Paint backPaint = Paint()
      ..isAntiAlias = true
      ..color = const Color(0xFF0A6800);
    canvas.drawPath(backPath, backPaint);

    // -------------------------------------------------------------------------
    // LAYER 2: FRONT WAVE (Bright Light Yellow-Green Gradient)
    // -------------------------------------------------------------------------
    final Path frontPath = Path();
    
    // 1. START POINT (Left edge of screen): (x = 0, y = 18)
    frontPath.moveTo(0, 50);

    // 2. CUBIC BÉZIER CURVE:
    // - Control Point 1 (size.width * 0.35, 45): Dips the left crest down to y = 45.
    // - Control Point 2 (size.width * 0.65, 4): Swoops the right crest up high to y = 4.
    // - End Point (size.width, 16): Meets the right screen edge at y = 16.
    frontPath.cubicTo(
      size.width * 0.35, 45,
      size.width * 0.32, 10,
      size.width, 4,
    );
    frontPath.lineTo(size.width, size.height);
    frontPath.lineTo(0, size.height);
    frontPath.close();

    final Paint frontPaint = Paint()
      ..isAntiAlias = true
      // ─── CHANGE GRADIENT COLORS HERE ───
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF8CE400), // Top light lime color
          Color(0xFF18B200), // Bottom deep emerald color
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(frontPath, frontPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
