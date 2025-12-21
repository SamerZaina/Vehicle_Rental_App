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
    final AgencyCarsController controller = Get.put(AgencyCarsController());

    return Scaffold(
      backgroundColor: dark ? RColors.black : RColors.white,

      /// ➕ ADD VEHICLE
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.to(() => const AddNewVehicle());

          /// ✅ Refresh list after successful add AND show success message
          if (result == true) {
            // Show success message
            Get.snackbar(
              'تم التحديث',
              'تم تحديث قائمة المركبات',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: Duration(seconds: 2),
              icon: Icon(Icons.refresh, color: Colors.white),
            );

            // Refresh the list
            controller.fetchAgencyCars();
          }
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 50.sp,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          controller.errorMessage.value,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () => controller.fetchAgencyCars(),
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                /// EMPTY
                if (controller.vehicles.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_car_outlined,
                          size: 60.sp,
                          color: dark ? RColors.white : RColors.textPrimary,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No vehicles available',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: dark ? RColors.white : RColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                /// SUCCESS
                return ListView.builder(
                  itemCount: controller.vehicles.length,
                  padding: EdgeInsets.only(bottom: 100.h),
                  itemBuilder: (context, index) {
                    try {
                      final vehicle = controller.vehicles[index];

                      // Safely extract all values with null checks
                      final brandName = vehicle.model.brand?.name ?? 'Unknown';
                      final modelName = vehicle.model.name;
                      final vehicleType = vehicle.model.brand?.type ?? 'سيارة';
                      final rating = vehicle.rate;
                      final seats = vehicle.seats;
                      final price = vehicle.pricePerHour;
                      final status = vehicle.status;
                      final fullName = '$brandName $modelName';

                      // Get appropriate image URL
                      String imageUrl = _getVehicleImage(
                        imagesPaths: vehicle.imagesPaths,
                        vehicleType: vehicleType,
                      );

                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: VehicleItemCard(
                          image: imageUrl,
                          name: fullName,
                          rating: _vehicleRate(rating),
                          seats: '$seats مقاعد ',
                          price: '$price / ساعة',
                          status: status == 'available' ? 'نشطة' : 'غير نشطة',
                        ),
                      );
                    } catch (e, stackTrace) {
                      // If there's an error rendering a vehicle, show error card
                      print('Error rendering vehicle at index $index: $e');
                      print('Stack trace: $stackTrace');
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8.w),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.red),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  'Error loading vehicle data',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Get vehicle image with priority:
  /// 1. First uploaded image (if available and valid)
  /// 2. Default asset image based on vehicle type
  String _getVehicleImage({
    required List<String>? imagesPaths,
    required String vehicleType,
  }) {
    if (imagesPaths == null || imagesPaths.isEmpty) {
      return _vehicleImage(vehicleType);
    }

    final rawPath = imagesPaths.first;

    // there's an error when it's try to show images of the car
    // that because the Your API returns image paths like this
    // ["cars\/cbxpvrAjUE4WzQiYmeB9gGut2PzeYiMLd8bK7Npy.jpg"]
    // so below the solution
    final cleanPath = rawPath
        .replaceAll('\\/', '/') // 🔥 THIS IS THE KEY FIX
        .replaceAll('"', '')
        .trim();

    final imageUrl = 'http://10.0.2.2:8000/storage/$cleanPath';

    debugPrint('🖼 Vehicle Image URL: $imageUrl');

    return imageUrl;
  }


  /// 🔹 Vehicle image selector (returns asset paths)
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
}