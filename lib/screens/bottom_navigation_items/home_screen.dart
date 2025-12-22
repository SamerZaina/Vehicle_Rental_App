import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vehicle_rental_app/data/controllers/user/user_controller.dart';
import 'package:vehicle_rental_app/screens/login/forget_password.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';
import 'package:vehicle_rental_app/utils/constants/sizes.dart';
import 'package:vehicle_rental_app/utils/constants/text_strings.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/theme/theme.dart';
import 'package:vehicle_rental_app/widgets/RAppbar.dart';

import '../../utils/constants/colors.dart';
import '../../widgets/car_card.dart';
import '../../widgets/favourite_icon.dart';
import '../../widgets/search_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    final List<Map<String, dynamic>> cars = [
      {
        "image": RImages.car1,
        "name": "فيراري",
        "rating": "5.0",
        "location": "غزة",
        "seats": "4 مقاعد",
        "price": "\$200/اليوم",
      },
      {
        "image": RImages.car2,
        "name": "تسلا موديل 5",
        "rating": "5.0",
        "location": "غزة",
        "seats": "5 مقاعد",
        "price": "\$100/اليوم",
      },
    ];
     final  List<Map<String , dynamic>> brands = [

     ];

    return Scaffold(
      appBar: dark ? RAppbarTheme.darkAppBarTheme(
        actions: [
          Container(
            width: 40.w,
            height: 40.h,
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Obx( () => CircleAvatar(
                  backgroundColor: RColors.primary40,
                  backgroundImage: UserController.instance.profileImageUrl.value.isNotEmpty
                      ? NetworkImage(UserController.instance.profileImageUrl.value)
                      : AssetImage(RImages.user)
              ),
            ),
          ) ,
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: BoxBorder.all(
                    width: 1.w ,
                    color: RColors.grey
                )
            ),
            width: 40.w,
            height: 40.h,
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Icon(CupertinoIcons.bell ,
                color: RColors.grey
            ),
          ) ,
          
        ]
      )
          : RAppbarTheme.lightAppBarTheme(
          actions: [
            Container(
              width: 40.w,
              height: 40.h,
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child:  Obx( () => CircleAvatar(
                  backgroundColor: RColors.primary40,
                  backgroundImage: UserController.instance.profileImageUrl.value.isNotEmpty
                      ? NetworkImage(UserController.instance.profileImageUrl.value)
                      : AssetImage(RImages.user)
              ),
              ),
            ) ,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: BoxBorder.all(
                  width: 1.w ,
                  color: RColors.grey
                )
              ),
              width: 40.w,
              height: 40.h,
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Icon(CupertinoIcons.bell ,
                  color: RColors.darkerGrey
              ),
            ) ,
          ]
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 20.h, 25.w, 0),
                child:
                    Column(
                      children: [
                        searchBar() ,
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Row(
                            children: [
                              Text('المركبات' ,
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold ,
                                  color: dark ?RColors.primary40 : RColors.primary,
          
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 20, 0, 10),
                                  width: 70.w,
                                  height: 70.h,
                                  decoration:BoxDecoration(
                                      color: RColors.primary,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Icon(CupertinoIcons.car, color: RColors.white,size: 30.sp,),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  child: Text('سيارات',
                                    //style: TextStyle(fontWeight: FontWeight.w600),

                                  ) ,)
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 20, 0, 10),
                                  width: 70.w,
                                  height: 70.h,
                                  decoration:BoxDecoration(
                                      color: RColors.primary,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Icon(CupertinoIcons.car, color: RColors.white,size: 30.sp,),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  child: Text('سيارات',
                                    //style: TextStyle(fontWeight: FontWeight.w600),

                                  ) ,)
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 20, 0, 10),
                                  width: 70.w,
                                  height: 70.h,
                                  decoration:BoxDecoration(
                                      color: RColors.primary,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Icon(CupertinoIcons.car, color: RColors.white,size: 30.sp,),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  child: Text('سيارات',
                                    //style: TextStyle(fontWeight: FontWeight.w600),

                                  ) ,)
                              ],
                            )
                          ],
                        ) ,
          
                      ],
                    ),

              ),
              SizedBox(height: RSizes.spaceBtwItems.h,),

              Container(
                margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                width: 430.w,
                height: 600.h,
                decoration: BoxDecoration(
                    color: dark ? RColors.black :RColors.white ,
                  borderRadius: BorderRadius.circular(30.r)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 25, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('أفضل السيارات',
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold ,
                      color: dark ?RColors.primary40 : RColors.primary,) ),
                          TextButton(
                              onPressed: (){},
                              child: Text(
                                'عرض الكل',
                                style: TextStyle(
                                  fontSize: 14.sp ,
                                  color: dark? RColors.grey :RColors.darkerGrey
                                ),
                              ))
                        ],
                      ),
                    ) ,
                    SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cars.length,
                        padding: const EdgeInsets.symmetric(horizontal:10),
                        itemBuilder: (context, index) {
                          final car = cars[index];
                          return CarCard(
                            image: car["image"],
                            name: car["name"],
                            rating: car["rating"],
                            location: car["location"],
                            seats: car["seats"],
                            price: car["price"],
                          );
                        },
                      ),
                    ) ,
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 25, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('مميز',
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold ,
                                color: dark ?RColors.primary40 : RColors.primary,) ),
                          TextButton(
                              onPressed: (){},
                              child: Text(
                                'عرض الكل',
                                style: TextStyle(
                                    fontSize: 14.sp ,
                                    color: dark? RColors.grey :RColors.darkerGrey
                                ),
                              ))
                        ],
                      ),
                    ) ,
                      Container(
                        width: 390.w,
                        height: 145.h,
                        decoration: BoxDecoration(
                          color: RColors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(15.r)
                        ),
                        child: Image.asset(RImages.car3,
                        width: 100.w,
                        height: 100.h,
                          fit: BoxFit.contain,
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(height: 15,)
            ],
          ),
        ),
        ),

    );
  }
}




