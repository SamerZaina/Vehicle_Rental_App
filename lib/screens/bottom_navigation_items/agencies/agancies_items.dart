import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vehicle_rental_app/screens/bottom_navigation_items/details/details_page.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../widgets/RAppbar.dart';
import '../../../widgets/car_card.dart';
import '../../../widgets/search_bar.dart';

class AganciesItems extends StatefulWidget {
  const AganciesItems({super.key});

  @override
  State<AganciesItems> createState() => _AganciesItemsState();
}

class _AganciesItemsState extends State<AganciesItems> {

  @override
  Widget build(BuildContext context) {
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
      {
        "image": RImages.car2,
        "name": "تسلا موديل 5",
        "rating": "5.0",
        "location": "غزة",
        "seats": "5 مقاعد",
        "price": "\$100/اليوم",
      },
      {
        "image": RImages.car2,
        "name": "تسلا موديل 5",
        "rating": "5.0",
        "location": "غزة",
        "seats": "5 مقاعد",
        "price": "\$100/اليوم",
      },   {
        "image": RImages.car2,
        "name": "تسلا موديل 5",
        "rating": "5.0",
        "location": "غزة",
        "seats": "5 مقاعد",
        "price": "\$100/اليوم",
      },   {
        "image": RImages.car2,
        "name": "تسلا موديل 5",
        "rating": "5.0",
        "location": "غزة",
        "seats": "5 مقاعد",
        "price": "\$100/اليوم",
      },   {
        "image": RImages.car2,
        "name": "تسلا موديل 5",
        "rating": "5.0",
        "location": "غزة",
        "seats": "5 مقاعد",
        "price": "\$100/اليوم",
      },   {
        "image": RImages.car2,
        "name": "تسلا موديل 5",
        "rating": "5.0",
        "location": "غزة",
        "seats": "5 مقاعد",
        "price": "\$100/اليوم",
      },   {
        "image": RImages.car2,
        "name": "تسلا موديل 5",
        "rating": "5.0",
        "location": "غزة",
        "seats": "5 مقاعد",
        "price": "\$100/اليوم",
      },   {
        "image": RImages.car2,
        "name": "تسلا موديل 5",
        "rating": "5.0",
        "location": "غزة",
        "seats": "5 مقاعد",
        "price": "\$100/اليوم",
      },   {
        "image": RImages.car2,
        "name": "تسلا موديل 5",
        "rating": "5.0",
        "location": "غزة",
        "seats": "5 مقاعد",
        "price": "\$100/اليوم",
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
    final dark = RHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: dark ?RAppbarTheme.darkAppBarTheme(
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
              onPressed: ()=> Get.back(),
              color: RColors.darkerGrey, icon:Icon( CupertinoIcons.left_chevron),
            ),
          ) ,
          title: Text('اسم المعرض' ,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold
            ),),
          actions: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: BoxBorder.all(
                      width: 1.w ,
                      color: RColors.grey
                  )
              ),
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: IconButton(
                onPressed: (){},
                color: RColors.darkerGrey, icon:Icon( CupertinoIcons.search),
              ),
            ) ,
          ]
      )
          : RAppbarTheme.lightAppBarTheme(
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
              onPressed: ()=> Get.back(),
              color: RColors.darkerGrey, icon:Icon( CupertinoIcons.left_chevron),
            ),
          ) ,
          title: Text('اسم المعرض' ,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize:20.sp,
                fontWeight: FontWeight.bold
            ),),
          actions: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: BoxBorder.all(
                      width: 1.w ,
                      color: RColors.grey
                  )
              ),
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: IconButton(
                onPressed: (){},
                color: RColors.darkerGrey, icon:Icon( CupertinoIcons.search),
              ),
            ) ,
          ]
      ) ,
      body: Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 0.h,
                crossAxisSpacing: 15.w,
              ),
                   scrollDirection: Axis.vertical,
              itemCount: cars.length,
              padding: const EdgeInsets.symmetric(horizontal:10),
              itemBuilder: (context, index) {
                final car = cars[index];
                return  GestureDetector(
                  onTap: ()=> Get.to(DetailsPage()),
                  child: SizedBox(
                      height: 280.h,
                      child: CarCardBookButton(
                    image: car["image"]??'',
                    name: car["name"]??'',
                    rating: car["rating"]??'',
                    location: car["location"]??'',
                    seats: car["seats"]??'',
                    price: car["price"]??'',
                  ), ),
                );
              },

            ),
          ],
        ),
      ),
              ),
    );
  }
}
