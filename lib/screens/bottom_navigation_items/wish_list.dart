import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vehicle_rental_app/widgets/RAppbar.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/helpers/helper_functions.dart';
import 'agencies/agancies_items.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar:  dark ?RAppbarTheme.darkAppBarTheme(
        leadingWidth: 62.w,
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: BoxBorder.all(
                  width: 1.w,
                  color: RColors.grey
              )
          ),
          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
          child: IconButton(
            onPressed: () => Get.back(),
            color: RColors.darkerGrey, icon: Icon(CupertinoIcons.left_chevron),
          ),
        ),
        title: Text('المفضلة' ,
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(
              fontWeight: FontWeight.bold
          ),),

      ) : RAppbarTheme.lightAppBarTheme(
        leadingWidth: 62.w,
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: BoxBorder.all(
                  width: 1.w ,
                  color: RColors.grey
              )
          ),
          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
          child: IconButton(
            onPressed: () => Get.back(),
            color: RColors.darkerGrey, icon:Icon( CupertinoIcons.left_chevron),
          ),
        ) ,
        title: Text('المفضلة' ,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize:20.sp,
              fontWeight: FontWeight.bold
          ),),

      ) ,
        body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: 400.w,
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        width:350.w,
                        height: 180.h,
                        margin: EdgeInsets.fromLTRB(12,5, 0, 0),
                        child: Card(
                          elevation: 1.5,
                          shadowColor: RColors.primary40,
                          color: dark? RColors.black :RColors.white,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                width: 1.2.w,
                                color: dark ?RColors.primary40: RColors.grey,
                              )
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 15,10,0) ,
                                    child: GestureDetector(
                                      onTap: ()=> Get.to(AganciesItems()),
                                      child: Card(
                                        shadowColor: RColors.primary,
                                        color:dark ? RColors.darkGrey : Colors.grey,
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.r),
                                          side: BorderSide(
                                              color: RColors.primary70
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(5.w.h),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20.r),
                                            child: Image.asset(
                                              RImages.car2,
                                              width: 120.w,
                                              height: 120.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'اسم المركبة' ,
                                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.bold
                                            )
                                        ),
                                        SizedBox(height: 4.h),
                                        Row(
                                          children: [
                                            Icon(CupertinoIcons.placemark ),

                                            Text(
                                              'مكان المركبة',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.sp,
                                              ),

                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(CupertinoIcons.money_dollar ),
                                            Text(
                                              'السعر',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.sp,
                                              ),

                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(15, 5, 0, 0),
                                    width: 100.w,
                                    height: 45.h,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: RColors.primary,
                                            padding: EdgeInsets.zero
                                        ),
                                        onPressed: (){},
                                        child: Text('احجز الآن',
                                          style: TextStyle(
                                              color: RColors.white ,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold
                                          ),)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );}


                ),
              ],
            ),
          ),
        )

    );
  }
}
