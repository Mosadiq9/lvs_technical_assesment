import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

typedef CustomBottomNavBar = CustomBottomNavigationBar;

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  // Customizable parameters to easily control curve depth, notch gap, and roundness
  final double navbarTopOffset;
  final double floatingButtonSize;
  final double notchMargin;        // Directly controls the transparent gap between hotspot button and green navbar
  final double topCornerRadius;
  final double? notchRadius;       // If null, computed automatically as (floatingButtonSize / 2) + notchMargin
  final double notchSmoothness;
  final double? notchDepth;        // If null, computed automatically to match notchRadius
  final double bottomGap;          // Manually control space below bottom navbar (set 0.0 to sit flush at screen bottom)

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.navbarTopOffset = 24.0,       // Height reserved above the green bar for the top half of floating button
    this.floatingButtonSize = 56.0,    // Diameter of the white circular Go Live button
    this.notchMargin = 4.0,            // Direct transparent gap around the button
    this.topCornerRadius = 26.0,       // Roundness of left and right top corners of navbar
    this.notchRadius,                  // Automatically calculated if null
    this.notchSmoothness = 20.0,       // Smoothness/width of bezier transition entering the notch
    this.notchDepth,                   // Automatically calculated if null
    this.bottomGap = 0.0,              // 0.0 removes system gap so navbar touches bottom edge
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveNotchRadius = notchRadius ?? ((floatingButtonSize / 2) + notchMargin);
    final double effectiveNotchDepth = notchDepth ?? effectiveNotchRadius;

    // Transparent container so content shines through the curved cutout
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomGap.h),
        child: SizedBox(
          height: (navbarTopOffset + 70.0).h,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              // 1. Curved Background with Horizontal Linear Gradient & Shadow
              Positioned.fill(
                child: CustomPaint(
                  painter: _NavBarBackgroundPainter(
                    topOffset: navbarTopOffset.h,
                    topCornerRadius: topCornerRadius.r,
                    notchRadius: effectiveNotchRadius.w,
                    notchSmoothness: notchSmoothness.w,
                    notchDepth: effectiveNotchDepth.h,
                  ),
                ),
              ),

              // 2. Navigation Items Row (Home, Party, [Space], Chats, Profile)
              Positioned(
                top: navbarTopOffset.h,
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _NavItem(
                          icon: BootstrapIcons.house_fill,
                          label: 'Home',
                          isSelected: currentIndex == 0,
                          onTap: () => onTap(0),
                        ),
                      ),
                      Expanded(
                        child: _NavItem(
                          icon: LucideIcons.partyPopper,
                          label: 'Party',
                          isSelected: currentIndex == 1,
                          onTap: () => onTap(1),
                        ),
                      ),
                      // Center Space (Reserved for Go Live notch)
                      Expanded(
                        child: GestureDetector(
                          onTap: () => onTap(2),
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Go Live',
                                style: GoogleFonts.inter(
                                  fontSize: 11.sp,
                                  fontWeight: currentIndex == 2 ? FontWeight.w700 : FontWeight.w500,
                                  color: currentIndex == 2 ? Colors.white : Colors.white.withValues(alpha: 0.75),
                                ),
                              ),
                              SizedBox(height: 8.h),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: _NavItem(
                          icon: LucideIcons.send,
                          label: 'Chats',
                          isSelected: currentIndex == 3,
                          onTap: () => onTap(3),
                        ),
                      ),
                      Expanded(
                        child: _NavItem(
                          icon: LucideIcons.user,
                          label: 'Profile',
                          isSelected: currentIndex == 4,
                          onTap: () => onTap(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Independent Floating Center Button (Go Live)
              Positioned(
                top: navbarTopOffset.h - (floatingButtonSize.w / 2),
                child: GestureDetector(
                  onTap: () => onTap(2),
                  child: Container(
                    width: floatingButtonSize.w,
                    height: floatingButtonSize.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.sensors,
                        color: const Color(0xFF19B200), // Vibrant green broadcast icon
                        size: 28.w,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color itemColor = isSelected ? Colors.white : Colors.white.withValues(alpha: 0.70);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: itemColor,
            size: 24.w,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: itemColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarBackgroundPainter extends CustomPainter {
  final double topOffset;
  final double topCornerRadius;
  final double notchRadius;
  final double notchSmoothness;
  final double notchDepth;

  _NavBarBackgroundPainter({
    required this.topOffset,
    required this.topCornerRadius,
    required this.notchRadius,
    required this.notchSmoothness,
    required this.notchDepth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    final double center = size.width / 2;
    final double top = topOffset;
    final double notchBottomY = top + notchDepth;

    // Build the smooth symmetrical curved shape
    path.moveTo(0, size.height);
    path.lineTo(0, top + topCornerRadius);
    path.quadraticBezierTo(0, top, topCornerRadius, top);

    // Flat line to left start of center notch
    final double leftNotchStart = center - notchRadius - notchSmoothness;
    path.lineTo(leftNotchStart, top);

    // Left half of continuous U curve: smooth horizontal shoulder into vertical U wall down to flat bottom center
    path.cubicTo(
      leftNotchStart + (notchSmoothness * 0.65), top, // Control point 1: gently curve off top edge
      center - (notchRadius * 0.55), notchBottomY,      // Control point 2: approach bottom center horizontally
      center, notchBottomY,                           // End point: exact bottom center of U
    );

    // Right half of continuous U curve: flat bottom center up vertical U wall to smooth horizontal shoulder
    final double rightNotchEnd = center + notchRadius + notchSmoothness;
    path.cubicTo(
      center + (notchRadius * 0.55), notchBottomY,      // Control point 1: exact mirror tangent at bottom center
      rightNotchEnd - (notchSmoothness * 0.65), top,  // Control point 2: approach right top edge horizontally
      rightNotchEnd, top,                             // End point: back on flat top edge
    );

    // Flat line to right corner
    path.lineTo(size.width - topCornerRadius, top);
    path.quadraticBezierTo(size.width, top, size.width, top + topCornerRadius);

    path.lineTo(size.width, size.height);
    path.close();

    // 1. Draw subtle shadow beneath/around the navigation bar
    canvas.drawShadow(path, Colors.black.withValues(alpha: 0.22), 8.0, false);

    // 2. Draw horizontal linear gradient fill (lime/yellow-green to darker green)
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFC8E800), // Bright lime/yellow-green left
          Color(0xFF14B200), // Rich darker green right
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, top, size.width, size.height - top));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _NavBarBackgroundPainter oldDelegate) {
    return oldDelegate.topOffset != topOffset ||
        oldDelegate.topCornerRadius != topCornerRadius ||
        oldDelegate.notchRadius != notchRadius ||
        oldDelegate.notchSmoothness != notchSmoothness ||
        oldDelegate.notchDepth != notchDepth;
  }
}
