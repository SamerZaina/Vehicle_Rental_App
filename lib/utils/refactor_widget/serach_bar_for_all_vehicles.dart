import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../controller/agency_all_vehicles_controller.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';
import '../constants/text_strings.dart';
import '../helpers/helper_functions.dart';
import 'filter_dialog.dart';



class SearchBarForAllVehilces extends StatefulWidget {
  const SearchBarForAllVehilces({super.key});

  @override
  State<SearchBarForAllVehilces> createState() => _SearchBarForAllVehilcesState();
}

class _SearchBarForAllVehilcesState extends State<SearchBarForAllVehilces> {
  final TextEditingController _searchController = TextEditingController();
  final AgencyCarsController _controller = Get.find<AgencyCarsController>();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Initialize with current search query
    _searchController.text = _controller.searchQuery.value;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Cancel previous timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Start a new timer with 500ms delay for API calls
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _controller.searchVehicles(query);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _controller.searchVehicles('');
  }

  void _showFilterDialog() {
    Get.dialog(
      FilterDialog(
        currentRating: _controller.minRating.value,
        onRatingChanged: (rating) {
          _controller.filterByRating(rating);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);

    return Row(
      children: [
        /// SEARCH FIELD WITH LOADING INDICATOR
        Expanded(
          child: Stack(
            children: [
              TextFormField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: RColors.darkGrey,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: RColors.darkGrey,
                      size: 20.sp,
                    ),
                    onPressed: _clearSearch,
                  )
                      : null,
                  filled: true,
                  hintText: RTexts.searchbar,
                  hintStyle: TextStyle(color: RColors.darkerGrey),
                  fillColor: dark ? RColors.primary70 : RColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(width: 1.w),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      width: 1,
                      color: RColors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      width: 1,
                      color: RColors.primary40,
                    ),
                  ),
                ),
              ),

              /// LOADING INDICATOR FOR API SEARCH
              Obx(() {
                if (_controller.isSearching.value) {
                  return Positioned(
                    right: 12.w,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: RColors.primary,
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              }),
            ],
          ),
        ),

        SizedBox(width: RSizes.defaultSpace * 0.8.w),

        /// FILTER BUTTON WITH BADGE
        Obx(() {
          final hasActiveFilters = _controller.activeFiltersCount > 0;

          return Stack(
            children: [
              GestureDetector(
                onTap: _showFilterDialog,
                child: Container(
                  width: 58.w,
                  height: 58.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: dark ? RColors.primary70 : RColors.white,
                    border: Border.all(
                      width: 1.w,
                      color: RColors.grey,
                    ),
                  ),
                  child: Icon(
                    CupertinoIcons.slider_horizontal_3,
                    color: RColors.darkerGrey,
                  ),
                ),
              ),

              /// FILTER BADGE
              if (hasActiveFilters)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: RColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_controller.activeFiltersCount}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ],
    );
  }
}