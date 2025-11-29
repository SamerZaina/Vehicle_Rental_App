import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';
import 'package:vehicle_rental_app/utils/constants/sizes.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/refactor_widget/vehicle_Item_Card.dart';
import 'package:vehicle_rental_app/widgets/search_bar.dart';

import 'add_new_vehicle.dart'; // Import the new screen

class MyVehicle extends StatelessWidget {
  const MyVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? RColors.black : RColors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddNewVehicle screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewVehicle()),
          );
        },
        backgroundColor: RColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: RSizes.md.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: RSizes.md.h),

            /// SEARCH BAR
            Container(
              margin: EdgeInsets.only(right: RSizes.lg.w),
              child: searchBar(),
            ),

            SizedBox(height: RSizes.lg.h),

            /// VEHICLES LIST
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                padding: EdgeInsets.only(bottom: 100.h), // Leave space for FAB
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: VehicleItemCard(
                      image: RImages.car2,
                      name: 'مرسيدس بنز',
                      rating: '4.${index % 5}',
                      seats: '5 مقاعد',
                      price: '200 / يوم',
                      status: index % 2 == 0 ? "نشطة" : "غير نشطة",
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
