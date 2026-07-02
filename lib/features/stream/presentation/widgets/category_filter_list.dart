import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/shared/widgets/category_chip.dart';
import '../../domain/entities/category_entity.dart';

class CategoryFilterList extends StatelessWidget {
  final List<CategoryEntity> categories;
  final String selectedCategoryId;
  final ValueChanged<String> onCategorySelected;

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
    this.chipHeight = 30.0,
    this.chipHorizontalPadding = 12.0,
    this.chipBorderRadius = 100.0,
    this.flagWidth = 14.0,
    this.flagHeight = 10.0,
    this.flagSpacing = 6.0,
    this.fontSize = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (chipHeight + 6.0).h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final category = categories[index];
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
