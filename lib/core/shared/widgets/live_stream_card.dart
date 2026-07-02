import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'network_image_widget.dart';
import 'country_flag.dart';

class LiveStreamCard extends StatelessWidget {
  final String imageUrl;
  final String streamerName;
  final String viewerCount;
  final String countryFlag;
  final VoidCallback onTap;
  final VoidCallback onFollow;

  const LiveStreamCard({
    super.key,
    required this.imageUrl,
    required this.streamerName,
    required this.viewerCount,
    required this.countryFlag,
    required this.onTap,
    required this.onFollow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            NetworkImageWidget(
              imageUrl: imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.15),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.85),
                    ],
                    stops: const [0.0, 0.25, 0.55, 1.0],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 10.h,
              left: 10.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.eye_fill,
                      color: Colors.white,
                      size: 11.w,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      viewerCount,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 10.h,
              left: 10.w,
              right: 10.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 26.w,
                    height: 26.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                      color: Colors.black.withValues(alpha: 0.25),
                    ),
                  ),
                  SizedBox(width: 8.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          streamerName,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 3.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CountryFlag(
                              countryCodeOrPath: countryFlag,
                              width: 14.w,
                              height: 10.h,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4.w),

                  GestureDetector(
                    onTap: onFollow,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD500),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Text(
                        '+ Follow',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 9.5.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
