import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vehicle_rental_app/customer/data/shop/controllers/agency_controller.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/widgets/RAppbar.dart';
import 'package:vehicle_rental_app/widgets/agency_shimmer.dart';

import '../../../utils/constants/colors.dart';
import 'agancies_items.dart';

class AgenciesScreen extends StatefulWidget {
  const AgenciesScreen({super.key});

  @override
  State<AgenciesScreen> createState() => _AgenciesScreenState();
}

class _AgenciesScreenState extends State<AgenciesScreen> {
  final controller = Get.put(AgencyController());

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: dark ? RAppbarTheme.darkAppBarTheme(
            leadingWidth: 62.w,
            leading: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  border: BoxBorder.all(
                      width: 1.w,
                      color: RColors.grey
                  )
              ),
              margin: EdgeInsets.fromLTRB(0, 0, 5.w, 0),
              child: IconButton(
                onPressed: () {},
                color: RColors.darkerGrey,
                icon: Icon(CupertinoIcons.left_chevron),
              ),
            ),
            title: Text('المعارض',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(
                  fontWeight: FontWeight.bold
              ),),
            actions: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: BoxBorder.all(
                        width: 1.w,
                        color: RColors.grey
                    )
                ),
                margin: EdgeInsets.fromLTRB(15.w, 0, 0, 0),
                child: IconButton(
                  onPressed: () {},
                  color: RColors.darkerGrey, icon: Icon(CupertinoIcons.search),
                ),
              ),
            ]
        )
            : RAppbarTheme.lightAppBarTheme(
            leadingWidth: 62.w,
            leading: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: BoxBorder.all(
                      width: 1.w,
                      color: RColors.grey
                  )
              ),
              margin: EdgeInsets.fromLTRB(0, 0, 5.w, 0),
              child: IconButton(
                onPressed: () {},
                color: RColors.darkerGrey,
                icon: Icon(CupertinoIcons.left_chevron),
              ),
            ),
            title: Text('المعارض',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold
              ),),
            actions: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: RColors.darkGrey),
                  ),
                  child: IconButton(
                    icon: Icon(
                      CupertinoIcons.search,
                      size: 20,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ]
        ),

        body: Obx(() {
          if (controller.isLoading.value) {
            return AgenciesShimmer();
          }
          if (controller.error.isNotEmpty) {
            return Center(
              child: Text(controller.error.value),
            );
          }
          if (controller.agencies.isEmpty) {
            return Center(child: Text('لا يوجد معارض'));
          }
          return Container(
            width: double.infinity.w,
            height: double.infinity.h,
            child: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: 370.w,
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.agencies.length,
                          itemBuilder: (context, index) {
                            final agency = controller.agencies[index];
                            return Container(
                              //width: 200.w,
                              height: 140.h,
                              margin: EdgeInsets.fromLTRB(0, 8.h, 0, 0),
                              child: Card(
                               // shadowColor: RColors.primary40,
                                color: dark ? RColors.blackF : RColors
                                    .primaryBackground,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                    borderSide: BorderSide(
                                      width: 1.2.w,
                                      color: dark ? RColors.primary40 : RColors
                                          .grey,
                                    )
                                ),
                                child: Stack(
                                    children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                  margin: EdgeInsets.all(7.w.h),
                                  child: Card(
                                   // shadowColor: RColors.primary,
                                    color: dark ? RColors.darkGrey : RColors
                                        .primaryBackground,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.r),
                                      side: BorderSide(
                                          color: RColors.primary70
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(5.w.h),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15.r),
                                          child: agency.profileImage != null ?
                                      Image.network(
                                      agency.profileImage!,
                                      width: 102.w,
                                      height: 95.h,
                                      fit: BoxFit.cover,
                                        errorBuilder: (context, error, stack) {
                                          return const Icon(Icons.image_not_supported);
                                        },
                                        loadingBuilder: (context, child, progress) {
                                          if (progress == null) return child;
                                          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                                        },
                                    ) :
                                    Image.asset(
                                    RImages.car1,
                                    width: 102.w,
                                    height: 95.h,
                                    fit: BoxFit.cover,
                                  ),
                                      ),
                                                        ),
                                                      ),
                                                        ),
                                                        SizedBox(width: 5.w),
                                                        Expanded(
                                                        child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                        Text(
                                                        agency.agencyName,
                                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                        fontWeight: FontWeight.bold
                                                        )
                                                        ),
                                                        SizedBox(height: 4.h),
                                                        Text(
                                                        agency.address,
                                                        style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12.sp,
                                                        ),
                                                        ),
                                                        ],
                                                        ),
                                                        ),
                                           Padding(
                                             padding: const EdgeInsets.all(8.0),
                                             child: ElevatedButton(
                                                 onPressed:  () => Get.to(AganciesItems(agency: agency,)),
                                                 style: ElevatedButton.styleFrom(
                                                   backgroundColor: RColors.primary,
                                                   padding: EdgeInsets.symmetric(
                                                     vertical: 0,
                                                     horizontal: 5.w
                                                   )
                                                 ),
                                                 child: Text('عرض المركبات',
                                                 style: TextStyle(
                                                   fontSize: 10.sp,
                                                   color: Colors.white
                                                 ),)),
                                           )
                                                        ],
                                                        ),
                                )
                            ],
                            ),
                            ),
                            );
                          }
              
              
                      ),
                      SizedBox(height: 100.h,)
              
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        )


    );
  }
}
