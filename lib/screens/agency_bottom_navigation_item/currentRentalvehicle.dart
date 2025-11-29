import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';
import 'package:vehicle_rental_app/utils/refactor_widget/current_rental_vehicle_card.dart';

class CurrentRentalVehicle extends StatelessWidget {
  const CurrentRentalVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        SizedBox(height: 10.h),

        // Example rented car card
        rentedCarCard(
          image: RImages.car2,
          name: "بي ام دبليو M3",
          renter: "أحمد محمد",
          date: "من 12:00 إلى 14:00",
        ),
        SizedBox(height: 15.h),
        rentedCarCard(
          image: RImages.car1,
          name: "مرسيدس GLE",
          renter: "علي سالم",
          date: "من 08:00 إلى 22:00",
        ),
      ],
    );
  }


}
