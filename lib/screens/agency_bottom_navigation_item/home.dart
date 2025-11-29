import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/refactor_widget/agencyCarCard.dart';
import 'package:vehicle_rental_app/utils/constants/sizes.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);

    final List<Map<String, dynamic>> cars = [
      {
        "image": RImages.car1,
        "name": "مرسيدس بنز",
        "rating": "5.0",
        "seats": "4 مقاعد",
        "price": "\$200/اليوم",
        "status": "غير مؤجرة"
      },
      {
        "image": RImages.car2,
        "name": "مرسيدس بنز GLE",
        "rating": "4.8",
        "seats": "5 مقاعد",
        "price": "\$100/اليوم",
        "status": "غير مؤجرة"
      },
      {
        "image": RImages.car3,
        "name": "بي ام دبليو ام 3",
        "rating": "4.9",
        "seats": "4 مقاعد",
        "price": "\$150/اليوم",
        "status": "غير مؤجرة"
      },
    ];

    final List<Map<String, dynamic>> cars2 = [
      {
        "image": RImages.car1,
        "name": "فيراري",
        "rating": "5.0",
        "seats": "4 مقاعد",
        "price": "\$200/اليوم",
        "status": "مؤجرة"
      },
      {
        "image": RImages.car2,
        "name": "تسلا موديل 5",
        "rating": "4.8",
        "seats": "5 مقاعد",
        "price": "\$100/اليوم",
        "status": "مؤجرة"
      },
      {
        "image": RImages.car3,
        "name": "مرسيدس",
        "rating": "4.9",
        "seats": "4 مقاعد",
        "price": "\$150/اليوم",
        "status": "مؤجرة"
      },
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: RSizes.md.h),
          _sectionHeader(context, title: "المركبات الأعلى تقييماً", dark: dark),
          _CarList(cars, context),
          _sectionHeader(context, title: "المركبات المضافة حديثا", dark: dark),
          _CarList2(cars2, context),
          _sectionHeader(context, title: "مركبات مميزة", dark: dark),
          _CarList(cars, context),
          SizedBox(height: RSizes.md.h),
          SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, {required String title, required bool dark}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(RSizes.md.w, RSizes.sm.h, RSizes.lg.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: dark ? RColors.primary40 : RColors.primary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'عرض الكل',
              style: TextStyle(
                fontSize: RSizes.fontSizeSm.sp,
                color: dark ? RColors.grey : RColors.darkerGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _CarList(List<Map<String, dynamic>> cars, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.45;
    return SizedBox(
      height: 260.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cars.length,
        padding: EdgeInsets.symmetric(horizontal: RSizes.sm.w),
        itemBuilder: (context, index) {
          final car = cars[index];
          return Padding(
            padding: EdgeInsets.only(right: RSizes.sm.w),
            child: SizedBox(
              width: cardWidth,
              child: AgencyCarCard(
                image: car["image"],
                name: car["name"],
                rating: car["rating"],
                seats: car["seats"],
                price: car["price"],
                status: car["status"],
              ),
            ),
          );
        },
      ),
    );
  }

  _CarList2(List<Map<String, dynamic>> cars, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = screenWidth * 0.45;
    return SizedBox(
      height: 260.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cars.length,
        padding: EdgeInsets.symmetric(horizontal: RSizes.sm.w),
        itemBuilder: (context, index) {
          final car = cars[index];
          return Padding(
            padding: EdgeInsets.only(right: RSizes.sm.w),
            child: SizedBox(
              width: cardWidth,
              child: AgencyCarCard(
                image: car["image"],
                name: car["name"],
                rating: car["rating"],
                seats: car["seats"],
                price: car["price"],
                status: car["status"],
              ),
            ),
          );
        },
      ),
    );
  }
}
