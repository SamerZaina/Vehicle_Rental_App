import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/constants/sizes.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';

/// ===================== CAR CARD =====================
class VehicleItemCard extends StatelessWidget {
  final String image;
  final String name;
  final String rating;
  final String seats;
  final String price;
  final String status;

  const VehicleItemCard({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.seats,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    final bool isActive = status == "نشطة";

    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.symmetric(vertical: RSizes.sm.h),
      decoration: BoxDecoration(
        color: dark ? RColors.darkGrey : RColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// VEHICLE IMAGE
          _buildVehicleImage(image),

          SizedBox(width: RSizes.lg.w),

          /// TEXT DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// NAME
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                    color: dark ? RColors.white : RColors.textPrimary,
                  ),
                ),
                SizedBox(height: 6.h),

                /// RATING
                Row(
                  children: [
                    Icon(Icons.star, size: 18.sp, color: Colors.orange),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        rating,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: dark ? RColors.white : RColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),

                /// STATUS
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.green.withOpacity(0.15)
                        : Colors.red.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: isActive ? Colors.green : Colors.red,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 6.h),

                /// SEATS + PRICE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.event_seat, size: 12.sp, color: Colors.grey),
                        SizedBox(width: 6.w),
                        Text(
                          seats,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: dark ? RColors.white : RColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.attach_money,
                            size: 12.sp,
                            color: Colors.black
                        ),
                        Text(
                          price,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                            color: dark ? RColors.white : RColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper method to build vehicle image with error handling
  Widget _buildVehicleImage(String imagePath) {
    // Check if it's a network image
    final isNetworkImage = imagePath.startsWith('http://') ||
        imagePath.startsWith('https://');

    if (isNetworkImage) {
      return Container(
        height: 90.h,
        width: 100.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.network(
            imagePath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              // If network image fails, show placeholder based on vehicle name
              return _buildPlaceholderImage(name);
            },
          ),
        ),
      );
    } else {
      // It's a local asset image
      return Container(
        height: 90.h,
        width: 100.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  /// Build placeholder image when network image fails
  Widget _buildPlaceholderImage(String vehicleName) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getVehicleIcon(vehicleName),
              size: 40,
              color: RColors.secondary,
            ),
            SizedBox(height: 4),
            Text(
              'صورة المركبة',
              style: TextStyle(
                fontSize: 10,
                color: RColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get appropriate icon based on vehicle name
  IconData _getVehicleIcon(String vehicleName) {
    if (vehicleName.toLowerCase().contains('باص') ||
        vehicleName.toLowerCase().contains('bus')) {
      return Icons.directions_bus;
    } else if (vehicleName.toLowerCase().contains('دراجة') ||
        vehicleName.toLowerCase().contains('motorcycle')) {
      return Icons.motorcycle;
    } else {
      return Icons.directions_car;
    }
  }
}