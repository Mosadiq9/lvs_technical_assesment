import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

typedef CustomBottomNavBar = CustomBottomNavigationBar;

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  final double navbarTopOffset;
  final double floatingButtonSize;
  final double notchMargin;
  final double topCornerRadius;
  final double? notchRadius;
  final double notchSmoothness;
  final double? notchDepth;
  final double bottomGap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.navbarTopOffset = 24.0,
    this.floatingButtonSize = 56.0,
    this.notchMargin = 4.0,
    this.topCornerRadius = 26.0,
    this.notchRadius,
    this.notchSmoothness = 20.0,
    this.notchDepth,
    this.bottomGap = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveNotchRadius =
        notchRadius ?? ((floatingButtonSize / 2) + notchMargin);
    final double effectiveNotchDepth = notchDepth ?? effectiveNotchRadius;

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
                                  fontWeight: currentIndex == 2
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: currentIndex == 2
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.75),
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
                        color: const Color(0xFF19B200),
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
    final Color itemColor = isSelected
        ? Colors.white
        : Colors.white.withValues(alpha: 0.70);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: itemColor, size: 24.w),
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

    path.moveTo(0, size.height);
    path.lineTo(0, top + topCornerRadius);
    path.quadraticBezierTo(0, top, topCornerRadius, top);

    final double leftNotchStart = center - notchRadius - notchSmoothness;
    path.lineTo(leftNotchStart, top);

    path.cubicTo(
      leftNotchStart + (notchSmoothness * 0.65),
      top,
      center - (notchRadius * 0.55),
      notchBottomY,
      center,
      notchBottomY,
    );

    final double rightNotchEnd = center + notchRadius + notchSmoothness;
    path.cubicTo(
      center + (notchRadius * 0.55),
      notchBottomY,
      rightNotchEnd - (notchSmoothness * 0.65),
      top,
      rightNotchEnd,
      top,
    );

    path.lineTo(size.width - topCornerRadius, top);
    path.quadraticBezierTo(size.width, top, size.width, top + topCornerRadius);

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black.withValues(alpha: 0.22), 8.0, false);

    final Paint paint = Paint()
      ..isAntiAlias = true
      ..shader = const LinearGradient(
        colors: [Color(0xFFC8E800), Color(0xFF14B200)],
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
