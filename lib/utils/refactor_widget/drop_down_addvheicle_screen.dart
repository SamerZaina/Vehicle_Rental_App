import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';

Widget searchableDropdown({
  required List<String> items,
  required String? selectedValue,
  required ValueChanged<String> onSelected,
  required TextEditingController searchController,
  required String hintText,
  required bool isDropdownOpen,
  required VoidCallback onTap,
  required VoidCallback refresh, // pass setState from parent
}) {
  List<String> filteredItems = searchController.text.isEmpty
      ? items
      : items
      .where((item) => item.toLowerCase().contains(searchController.text.toLowerCase()))
      .toList();

  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          decoration: BoxDecoration(
            border: Border.all(color: RColors.grey),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedValue ?? hintText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: selectedValue != null ? Colors.black : RColors.grey,
                  ),
                ),
              ),
              Icon(
                isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: RColors.darkerGrey,
              ),
            ],
          ),
        ),
      ),

      if (isDropdownOpen) ...[
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: RColors.grey),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Search Field
              Padding(
                padding: EdgeInsets.all(8.w),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن $hintText...',
                    hintStyle: TextStyle(fontSize: 14.sp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    prefixIcon: Icon(Icons.search, size: 20.sp),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  ),
                  onChanged: (value) => refresh(), // call parent setState
                ),
              ),

              // Filtered List
              Container(
                constraints: BoxConstraints(maxHeight: 200.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        onSelected(item);
                        searchController.clear();
                        refresh(); // update UI
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ],
  );
}
