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
        borderRadius: BorderRadius.circular(20.r), // Increased corner radius
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image with proper BoxFit.cover
            NetworkImageWidget(
              imageUrl: imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            
            // Black transparent bottom gradient overlay for text readability
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
            
            // Viewer Count Badge (Top Left Corner exactly like reference)
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
                    Icon(Icons.remove_red_eye, color: Colors.white, size: 11.w),
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
            
            // Bottom Info Section
            Positioned(
              bottom: 10.h,
              left: 10.w,
              right: 10.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Profile Avatar Indicator (Smaller white outlined circle)
                  Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                      color: Colors.grey.shade400,
                    ),
                    child: const Icon(Icons.person, color: Colors.white, size: 16),
                  ),
                  SizedBox(width: 6.w),
                  
                  // Username and Country Flag aligned exactly
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
                  
                  // Follow Button (Bright yellow pill, smaller height, correct typography & bottom-right positioning)
                  GestureDetector(
                    onTap: onFollow,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD500),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Text(
                        '+ Follow',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
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
