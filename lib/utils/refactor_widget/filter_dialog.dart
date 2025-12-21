import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';


class FilterDialog extends StatelessWidget {
  final double currentRating;
  final Function(double) onRatingChanged;

  const FilterDialog({
    super.key,
    required this.currentRating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'تصفية حسب التقييم',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: dark ? Colors.white : Colors.black,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 24.sp),
                  onPressed: () => Get.back(),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            /// RATING OPTIONS
            ..._buildRatingOptions(dark),

            SizedBox(height: 20.h),

            /// ACTION BUTTONS
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      onRatingChanged(0.0); // Clear filter
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      side: BorderSide(color: RColors.primary),
                    ),
                    child: Text(
                      'إلغاء الفلتر',
                      style: TextStyle(
                        color: RColors.primary,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: RColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'تم',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRatingOptions(bool dark) {
    final ratingOptions = [
      {'label': 'كل التقييمات', 'value': 0.0},
      {'label': '⭐ 1+ فما فوق', 'value': 1.0},
      {'label': '⭐⭐ 2+ فما فوق', 'value': 2.0},
      {'label': '⭐⭐⭐ 3+ فما فوق', 'value': 3.0},
      {'label': '⭐⭐⭐⭐ 4+ فما فوق', 'value': 4.0},
      {'label': '⭐⭐⭐⭐⭐ 5 نجمة', 'value': 5.0},
    ];

    return ratingOptions.map((option) {
      final isSelected = currentRating == option['value'];

      return Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: GestureDetector(
          onTap: () => onRatingChanged(option['value'] as double),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? RColors.primary.withOpacity(0.1)
                  : dark ? Colors.grey.shade900 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? RColors.primary : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: isSelected ? RColors.primary : Colors.grey,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  option['label'] as String,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isSelected
                        ? RColors.primary
                        : dark ? Colors.white : Colors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                Spacer(),
                if (option['value'] as double > 0)
                  Row(
                    children: List.generate(
                      (option['value'] as double).toInt(),
                          (index) => Icon(
                        Icons.star,
                        size: 16.sp,
                        color: Colors.orange,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}