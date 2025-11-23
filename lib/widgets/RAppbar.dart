import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vehicle_rental_app/utils/constants/sizes.dart';
import '../utils/constants/colors.dart';

class RAppbarTheme {
  RAppbarTheme._();

  static AppBar lightAppBarTheme({Widget? leading , List<Widget>? actions}) => AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Container(
          color: Colors.grey.shade300,
          height: 1,
        )
      ),
    backgroundColor: RColors.primaryBackground,
    scrolledUnderElevation: 0,
    leadingWidth: 130.w,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          leading ??
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
            width: 42.w,
            height: 42.h,
            decoration: BoxDecoration(
              color: RColors.primary40,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Icon(
              CupertinoIcons.car_detailed,
              color: RColors.primaryBackground,
              size: 30.sp,
            ),
          ),
          SizedBox(width: RSizes.spaceBtwItems.w*0.5,),
          Text('رينتو',
            style: Theme.of(Get.context!).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold
            ),)
        ],
      ),
    ),
    actions: actions?? [
     // SizedBox(width: 150.w),
   //   SizedBox(width: 30.w),
    ],


  );

  static AppBar darkAppBarTheme({Widget? leading,List<Widget>? actions}) => AppBar(
    backgroundColor: RColors.blackF,
    bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Container(
          color: Colors.grey.shade300,
          height: 1,
        )
    ),
    scrolledUnderElevation: 0,
    leadingWidth: 130.w,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          leading ??
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
                width: 42.w,
                height: 42.h,
                decoration: BoxDecoration(
                  color: RColors.primary40,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Icon(
                  CupertinoIcons.car_detailed,
                  color: RColors.primaryBackground,
                  size: 30.sp,
                ),
              ),
          SizedBox(width: RSizes.spaceBtwItems.w*0.5,),
          Text('رينتو',
            style: Theme.of(Get.context!).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold
            ),)
        ],
      ),
    ),

    actions: actions?? [
    //  SizedBox(width: 150.w),

     // SizedBox(width: 30.w),
    ],


  );
}