import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'category_chip_shimmer.dart';
import 'stream_card_shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.0,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(width: 12.0),
            itemBuilder: (context, index) => const CategoryChipShimmer(),
          ),
        ),
        SizedBox(height: 8.h),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 8.h,
              bottom: 90.h,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.70,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
            ),
            itemCount: 6,
            itemBuilder: (context, index) => const StreamCardShimmer(),
          ),
        ),
      ],
    );
  }
}
