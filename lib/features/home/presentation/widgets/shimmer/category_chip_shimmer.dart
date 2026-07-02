import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryChipShimmer extends StatelessWidget {
  const CategoryChipShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 30.0,
        width: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
