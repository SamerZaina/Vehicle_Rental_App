// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vehicle_rental_app/utils/constants/colors.dart';
// import 'package:vehicle_rental_app/utils/constants/sizes.dart';
// import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
//
// class AgencyCarCard extends StatelessWidget {
//   final String image;
//   final String name;
//   final String rating;
//   final String seats;
//   final String price;
//   final String status;
//
//   const AgencyCarCard({
//     super.key,
//     required this.image,
//     required this.name,
//     required this.rating,
//     required this.seats,
//     required this.price,
//     this.status = "غير مؤجرة",
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final dark = RHelperFunctions.isDarkMode(context);
//     final bool isRented = status == "مؤجرة";
//
//     return Container(
//       width: 190.w,
//       margin: EdgeInsets.fromLTRB(3.w, 10.h, 3.w, 10.h),
//       decoration: BoxDecoration(
//         color: dark ? RColors.black : Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(
//           color: dark ? RColors.primary40 : Colors.grey.shade300,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // IMAGE
//           ClipRRect(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(16.r),
//               topRight: Radius.circular(16.r),
//             ),
//             child: Image.asset(
//               image,
//               height: 130.h,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//
//           // CAR NAME
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//             child: Text(
//               name,
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 15.sp,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//
//           // RATING
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 12.w),
//             child: Row(
//               children: [
//                 Icon(Icons.star, size: 16.sp, color: Colors.orange),
//                 SizedBox(width: 4.w),
//                 Expanded(
//                   child: Text(
//                     rating,
//                     style: TextStyle(fontSize: 14.sp),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//
//           SizedBox(height: 8.h),
//
//           // STATUS (smaller, like CarCard location row)
//
//
//           SizedBox(height: 8.h),
//
//           // FOOTER
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // SEATS
//                 Row(
//                   children: [
//                     Icon(Icons.event_seat, size: 10.sp, color: Colors.grey),
//                     SizedBox(width: 4.w),
//                     Text(
//                       seats,
//                       style: TextStyle(fontSize: 10.sp),
//                     ),
//                   ],
//                 ),
//                 // PRICE
//                 Row(
//                   children: [
//                     Icon(Icons.attach_money, size: 10.sp, color: Colors.black),
//                     Text(
//                       price,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 10.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/constants/sizes.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';

class AgencyCarCard extends StatelessWidget {
  final String image;
  final String name;
  final String rating;
  final String seats;
  final String price;
  final String status;

  const AgencyCarCard({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.seats,
    required this.price,
    this.status = "غير مؤجرة",
  });

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    final bool isRented = status == "مؤجرة";

    return Container(
      width: 190.w,
      margin: EdgeInsets.fromLTRB(3.w, 10.h, 3.w, 10.h),
      decoration: BoxDecoration(
        color: dark ? RColors.black : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: dark ? RColors.primary40 : Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🖼 IMAGE (FIXED)
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: _buildImage(),
          ),

          /// 🚗 CAR NAME
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          /// ⭐ RATING
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Icon(Icons.star, size: 16.sp, color: Colors.orange),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    rating,
                    style: TextStyle(fontSize: 14.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),

          /// FOOTER
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// SEATS
                Row(
                  children: [
                    Icon(Icons.event_seat, size: 10.sp, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Text(
                      seats,
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ],
                ),

                /// PRICE
                Row(
                  children: [
                    Icon(Icons.attach_money,
                        size: 10.sp, color: Colors.black),
                    Text(
                      price,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                      ),
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

  /// ✅ Smart image loader (Asset OR Network)
  Widget _buildImage() {
    final bool isNetworkImage = image.startsWith('http');

    return Image(
      image: isNetworkImage
          ? NetworkImage(image)
          : AssetImage(image) as ImageProvider,
      height: 130.h,
      width: double.infinity,
      fit: BoxFit.cover,

      /// 🛡 Fallback if network image fails
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          RImages.car1,
          height: 130.h,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
