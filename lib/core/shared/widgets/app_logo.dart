import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_assets.dart';

class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.26),
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
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFD2F500), Color(0xFF1FB200)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(size * 0.26),
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
                  fontSize: size * 0.29,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.0,
                  letterSpacing: -0.4,
                ),
              ),
              SizedBox(height: size * 0.03),
              Icon(
                Icons.videocam_rounded,
                color: Colors.white,
                size: size * 0.30,
              ),
            ],
          ),
        );
      },
    ));
  }
}
