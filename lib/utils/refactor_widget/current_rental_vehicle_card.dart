import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';

rentedCarCard({
  required String image,
  required String name,
  required String renter,
  required String date,
}) {
  return Container(
    padding: EdgeInsets.all(16.h), // increased padding
    decoration: BoxDecoration(
      color: RColors.white,
      borderRadius: BorderRadius.circular(18.r), // slightly bigger corners
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1), // slightly stronger shadow
          blurRadius: 12, // bigger blur
          offset: const Offset(0, 6),
        )
      ],
    ),
    child: Row(
      children: [
        // car image
        Container(
          width: 110.w, // increased width
          height: 70.h, // increased height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r), // bigger radius
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 16.w), // more space between image and details
        // Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // slightly bigger font
                  color: RColors.textPrimary,
                ),
              ),
              SizedBox(height: 6.h), // more spacing
              Text(
                "العميل: $renter",
                style: const TextStyle(
                  color: RColors.textSecondary,
                  fontSize: 15, // slightly bigger
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  color: RColors.textSecondary,
                  fontSize: 14, // slightly bigger
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
