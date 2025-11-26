import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../../../widgets/RAppbar.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: dark
          ? RAppbarTheme.darkAppBarTheme(
              leadingWidth: 62.w,
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: BoxBorder.all(width: 1.w, color: RColors.grey),
                ),
                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: IconButton(
                  onPressed: () => Get.back(),
                  color: RColors.darkerGrey,
                  icon: Icon(CupertinoIcons.left_chevron),
                ),
              ),
              title: Text(
                'تفاصيل الحجز',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : RAppbarTheme.lightAppBarTheme(
              leadingWidth: 62.w,
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: BoxBorder.all(width: 1.w, color: RColors.grey),
                ),
                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: IconButton(
                  onPressed: () => Get.back(),
                  color: RColors.darkerGrey,
                  icon: Icon(CupertinoIcons.left_chevron),
                ),
              ),
              title: Text(
                'تفاصيل الحجز',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 25.h, left: 15, right: 15),
              child: bookingStepper(currentStep),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                  
                ],
              ),
            ),
        
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: RColors.primary),
                onPressed: () {
                  if (currentStep < 2) {
                    setState(() {
                      currentStep++;
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: SizedBox(
                    width: 340.w,
                    height: 60.h,
                    child: Center(
                      child: Text(currentStep == 2 ? "إنهاء" : "التالي" ,
                        style: TextStyle(
                          color: RColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bookingStepper(int currentStep) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 60,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: 30,
              right: 30,
              top: 8,
              child: Container(height: 2, color: RColors.primary40),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildStepDot("تفاصيل الحجز", 0, currentStep),
                buildStepDot("طرق الدفع", 1, currentStep),
                buildStepDot("تأكيد الحجز", 2, currentStep),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStepDot(String title, int index, int currentStep) {
    bool isCurrent = index == currentStep;
    bool isPassed = index < currentStep;

    Color activeColor = RColors.primary;
    Color inactiveColor = Colors.grey.shade400;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPassed ? activeColor : RColors.primary,
          ),
          child: isCurrent
              ? Center(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
        ),
        const SizedBox(height: 4),
        Container(
          margin: EdgeInsets.all(5),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isCurrent ? activeColor : inactiveColor,
            ),
          ),
        ),
      ],
    );
  }
}
