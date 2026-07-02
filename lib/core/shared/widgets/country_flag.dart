import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryFlag extends StatelessWidget {
  final String countryCodeOrPath;
  final double? width;
  final double? height;

  const CountryFlag({
    super.key,
    required this.countryCodeOrPath,
    this.width,
    this.height,
  });

  String _resolveAssetPath(String input) {
    final lower = input.toLowerCase().trim();
    if (lower.contains('global') ||
        lower.contains('all') ||
        lower.contains('🌐') ||
        lower == 'un') {
      return 'assets/images/flags/global.png';
    }
    if (lower.contains('in') &&
        (lower == 'in' || lower.contains('india') || lower.contains('🇮🇳'))) {
      return 'assets/images/flags/in.png';
    }
    if (lower == 'ph' ||
        lower.contains('philippines') ||
        lower.contains('🇵🇭')) {
      return 'assets/images/flags/ph.png';
    }
    if (lower == 'br' || lower.contains('brazil') || lower.contains('🇧🇷')) {
      return 'assets/images/flags/br.png';
    }
    if (lower == 'co' || lower.contains('colombia') || lower.contains('🇨🇴')) {
      return 'assets/images/flags/co.png';
    }
    if (lower == 'mx' || lower.contains('mexico') || lower.contains('🇲🇽')) {
      return 'assets/images/flags/mx.png';
    }
    if (lower == 'ar' ||
        lower.contains('argentina') ||
        lower.contains('🇦🇷')) {
      return 'assets/images/flags/ar.png';
    }
    if (lower == 'us' || lower.contains('usa') || lower.contains('🇺🇸')) {
      return 'assets/images/flags/us.png';
    }
    if (lower.startsWith('assets/images/flags/')) {
      return input;
    }
    if (lower.startsWith('assets/flags/')) {
      return input.replaceAll('assets/flags/', 'assets/images/flags/');
    }
    return 'assets/images/flags/$lower.png';
  }

  @override
  Widget build(BuildContext context) {
    final assetPath = _resolveAssetPath(countryCodeOrPath);
    final w = width ?? 16.w;
    final h = height ?? 12.h;

    return ClipRRect(
      borderRadius: BorderRadius.circular(2.r),
      child: Image.asset(
        assetPath,
        width: w,
        height: h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: w,
            height: h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: Icon(
              Icons.flag_outlined,
              size: h * 0.8,
              color: Colors.grey.shade700,
            ),
          );
        },
      ),
    );
  }
}
