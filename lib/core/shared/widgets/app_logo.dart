import 'package:flutter/material.dart';
import '../../theme/app_assets.dart';

class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.logo,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Placeholder until logo is provided
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Text(
            'Alive',
            style: TextStyle(
              color: Colors.green.shade800,
              fontWeight: FontWeight.bold,
              fontSize: size * 0.3,
            ),
          ),
        );
      },
    );
  }
}
