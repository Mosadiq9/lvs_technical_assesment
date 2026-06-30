import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/shared/widgets/category_chip.dart';
import '../../domain/entities/category_entity.dart';

class CategoryFilterList extends StatelessWidget {
  final List<CategoryEntity> categories;
  final String selectedCategoryId;
  final ValueChanged<String> onCategorySelected;

  // ─── Control Country Chip Dimensions Here! ───
  final double chipHeight;
  final double chipHorizontalPadding;
  final double chipBorderRadius;
  final double flagWidth;
  final double flagHeight;
  final double flagSpacing;
  final double fontSize;

  const CategoryFilterList({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
    this.chipHeight = 30.0,            // Individual chip height (try 26, 28, 30, 32!)
    this.chipHorizontalPadding = 12.0, // Internal left/right padding inside each chip
    this.chipBorderRadius = 100.0,     // Roundness of each chip
    this.flagWidth = 14.0,             // Country flag width
    this.flagHeight = 10.0,            // Country flag height
    this.flagSpacing = 6.0,            // Gap between country flag and text label
    this.fontSize = 12.0,              // Font size of country text label
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Outer height dynamically adjusts to your exact chipHeight so it never gets cut off or forced!
      height: (chipHeight + 6.0).h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          // Wrapping in Center allows the chip to strictly obey chipHeight without ListView stretching it!
          return Center(
            child: CategoryChip(
              label: category.name,
              flagAsset: category.flagAsset,
              isSelected: category.id == selectedCategoryId,
              onTap: () => onCategorySelected(category.id),
              height: chipHeight,
              horizontalPadding: chipHorizontalPadding,
              borderRadius: chipBorderRadius,
              flagWidth: flagWidth,
              flagHeight: flagHeight,
              flagSpacing: flagSpacing,
              fontSize: fontSize,
            ),
          );
        },
      ),
    );
  }
}
