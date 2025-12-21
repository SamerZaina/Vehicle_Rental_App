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
          color: Colors.grey.withOpacity(0.3), // **Border**
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), // **Shadow color**
            blurRadius: 6, // spread
            spreadRadius: 1,
            offset: const Offset(0, 3), // shadow position
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// VEHICLE IMAGE
          Container(
            height: 90.h,
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
}
