import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';
import 'package:vehicle_rental_app/utils/constants/sizes.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/widgets/favourite_icon.dart';

import '../../../utils/constants/colors.dart';
import '../../../widgets/RAppbar.dart';
import 'booking_details.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update current Index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  // Jump to the specific dot selected
  void dotClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: dark ? RAppbarTheme.darkAppBarTheme(
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
        title: Text('تفاصيل المركبة',
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
        title: Text('تفاصيل المركبة',
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold
          ),),

      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    bottom: 15.h,
                    right: 175.w,
                    child: SmoothPageIndicator(controller: pageController,
                        onDotClicked: dotClick,
                        count: 3,
                        effect: WormEffect(
                          activeDotColor: dark ? RColors.light : RColors.dark,
                          dotHeight: 10,
                          dotWidth: 10,

                        )),
                  ),
                  Positioned(
                    top: 20.h,
                    right: 20.w,
                    child: FavouriteIcon(
                        icon: CupertinoIcons.heart,
                        height: 35.h,
                        width: 35.w),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
                    width: double.infinity,
                    height: 270.h,
                    child: PageView(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Image.asset(RImages.car1),
                        Image.asset(RImages.car2),
                        Image.asset(RImages.car1),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(30),
                margin: EdgeInsets.fromLTRB(0, 15.h, 0, 0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: dark ? RColors.dark : RColors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'مرسيدس موديل 5',
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),),
                        Row(
                          children: [
                            Icon(CupertinoIcons.money_dollar_circle, size: 14.sp,color: RColors.primary,),
                            Text('سعر الساعة  : 80\$'),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: RSizes.spaceBtwItems * 0.5.h,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'سيارة مرسيدس بسرعة عالية جدا بسعر التوفير من موديل 5 ويجعل محدا حوش',
                            style:Theme.of(context).textTheme.bodyMedium,
                          ),
                        ) ,
                        SizedBox(width: 20.w,),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(CupertinoIcons.star_fill,size: 15.sp, color: Colors.orange,),
                               SizedBox(width:3.w,),
                                Text('5.2'),
                              ],
                            ),
                            Text('(+100تقييم)' , style: TextStyle(color: RColors.darkGrey),),

                          ],
                        )
                      ],
                    ),
                    SizedBox(height: RSizes.spaceBtwSections,),
                    Divider(height: 2.h,thickness: 1.w,color: RColors.grey,),
                    SizedBox(height: RSizes.defaultSpace,),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: RColors.primary70,
                          child: Icon(CupertinoIcons.person),
                        ) ,
                        SizedBox(width: RSizes.spaceBtwItems.w,),
                        Text('اسم المعرض' ,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp
                        ),)
                      ],
                    ),
                    SizedBox(height: RSizes.defaultSpace,),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'خصائص السيارة',
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),),
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3 ,
                          mainAxisSpacing:15,
                          crossAxisSpacing: 5 ,
                          childAspectRatio: 1,
                        ),
                        itemCount: 6,
                        itemBuilder: (context ,index) {
                          return Container(
                            width: 117.w,
                            height: 117.w,
                            margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: RColors.grey
                            ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                   backgroundColor: RColors.white,
                                  child: Icon(CupertinoIcons.flame , color: RColors.darkerGrey,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Column(
                                    children: [
                                      Text('اسم الخاصية',
                                       style: TextStyle(
                                         fontWeight: FontWeight.bold,
                                         color: RColors.darkGrey
                                       ),),
                                      Text('الوصف',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                        ),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          );
                        }
                    ) ,
                    SizedBox(
                      width: 350.w,
                      height: 60.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(0, 0, 120, 0),
                          backgroundColor: RColors.primary,
                        ),
                          onPressed: ()=> Get.to(BookingDetails()),
                          child: Row(
                            children: [
                              Text('احجز الآن' ,
                              style: TextStyle(
                                fontSize: 22.sp,
                                color: RColors.white,
                                fontWeight: FontWeight.bold
                              ),),
                              SizedBox(width: RSizes.spaceBtwItems,),
                              Icon(CupertinoIcons.arrow_left ,
                                color: RColors.white,
                              size: 25.sp,),
                            ],
                          ) ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
