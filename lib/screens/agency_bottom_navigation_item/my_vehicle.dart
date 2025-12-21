import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:vehicle_rental_app/controller/agency_all_vehicles_controller.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';
import 'package:vehicle_rental_app/utils/constants/sizes.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/refactor_widget/vehicle_Item_Card.dart';
import 'package:vehicle_rental_app/widgets/search_bar.dart';

import 'add_new_vehicle.dart';

class MyVehicle extends StatelessWidget {
  const MyVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);

    /// ✅ Controller is created once
    final AgencyCarsController controller =
    Get.put(AgencyCarsController());

    return Scaffold(
      backgroundColor: dark ? RColors.black : RColors.white,

      /// ➕ ADD VEHICLE
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.to(() => const AddNewVehicle());

          /// ✅ Refresh list after successful add
          if (result == true) {
            controller.fetchAgencyCars();
          }
        },
        backgroundColor: RColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.startFloat,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: RSizes.md.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: RSizes.md.h),

            /// 🔍 SEARCH BAR
            Container(
              margin: EdgeInsets.only(right: RSizes.lg.w),
              child: searchBar(),
            ),

            SizedBox(height: RSizes.lg.h),

            /// 🚗 VEHICLES LIST
            Expanded(
              child: Obx(() {
                /// LOADING
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                /// ERROR
                if (controller.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.sp,
                      ),
                    ),
                  );
                }

                /// EMPTY
                if (controller.vehicles.isEmpty) {
                  return Center(
                    child: Text(
                      'No vehicles available',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: dark
                            ? RColors.white
                            : RColors.textPrimary,
                      ),
                    ),
                  );
                }

                /// SUCCESS
                return ListView.builder(
                  itemCount: controller.vehicles.length,
                  padding: EdgeInsets.only(bottom: 100.h),
                  itemBuilder: (context, index) {
                    final vehicle =
                    controller.vehicles[index];

                    // Safely handle all null values
                    final brandName = vehicle.model.brand?.name ?? 'Unknown';
                    final modelName = vehicle.model.name;
                    final vehicleType = vehicle.model.brand?.type ?? 'سيارة';
                    final rating = vehicle.rate;
                    final seats = vehicle.seats;
                    final price = vehicle.pricePerHour;
                    final status = vehicle.status;
                    final images = vehicle.imagesPaths ?? [];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: VehicleItemCard(
                        image: images.isNotEmpty
                            ? buildImageUrl(images.first)
                            : _vehicleImage(vehicleType),
                        name: '$brandName $modelName',
                        rating: _vehicleRate(rating),
                        seats: '$seats مقاعد ',
                        price: '$price / ساعة',
                        status: status == 'available'
                            ? 'نشطة'
                            : 'غير نشطة',
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Vehicle image selector
String _vehicleImage(String type) {
  if (type == "سيارة") return RImages.car2;
  if (type == "باص") return RImages.bus;
  if (type == "دراجة نارية") return RImages.motorcycle;
  return RImages.car1;
}

/// 🔹 Rating text
String _vehicleRate(String? rate) {
  if (rate == null || rate == 'null' || rate.isEmpty) {
    return "لم تقيم بعد";
  }
  return rate;
}

String buildImageUrl(String path) {
  return 'http://10.0.2.2:8000/storage/$path';
}