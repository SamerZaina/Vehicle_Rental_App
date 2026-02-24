import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/agency/controller/agency_all_vehicles_controller.dart';

import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/refactor_widget/agencyCarCard.dart';
import 'package:vehicle_rental_app/utils/constants/sizes.dart';

import '../controller/agency_home_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);

    final AgencyCarsController agencyCarsController = Get.put(AgencyCarsController());
    agencyCarsController.refreshData();
    final HomeController controller = Get.put(HomeController());
    controller.fetchHomeData();
    return Obx(() {

      // Loading state
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Empty / Error state
      if (controller.bestRatingCars.isEmpty &&
          controller.recentAddedCars.isEmpty &&
          controller.featuredCars.isEmpty) {
        return Center(
          child: Text(
            "لا توجد مركبات لعرضها",
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: RSizes.md.h),

            _sectionHeader(
              context,
              title: "المركبات الأعلى تقييماً",
              dark: dark,
            ),
            _carList(controller.bestRatingCars, context),

            _sectionHeader(
              context,
              title: "المركبات المضافة حديثا",
              dark: dark,
            ),
            _carList(controller.recentAddedCars, context),

            _sectionHeader(
              context,
              title: "مركبات مميزة",
              dark: dark,
            ),
            _carList(controller.featuredCars, context),

            SizedBox(height: RSizes.md.h),
            const SizedBox(height: 100),
          ],
        ),
      );
    });
  }

  Widget _sectionHeader(

      BuildContext context, {
        required String title,
        required bool dark,
      }) {
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

  Widget _carList(List vehicles, BuildContext context) {
    if (vehicles.isEmpty) {
      return SizedBox(
        height: 260.h,
        child: Center(
          child: Text(
            "لا توجد مركبات",
            style: TextStyle(color: RColors.grey, fontSize: 16.sp),
          ),
        ),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.45;

    return SizedBox(
      height: 260.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: vehicles.length,
        padding: EdgeInsets.symmetric(horizontal: RSizes.sm.w),
        itemBuilder: (context, index) {
          final vehicle = vehicles[index];

          final brandName = vehicle.model.brand?.name ?? '';
          final modelName = vehicle.model.name;
          final vehicleType = vehicle.model.brand?.type ?? 'سيارة';

          final seats = vehicle.seats;
          final status = vehicle.status;
          final price = vehicle.pricePerHour;
          final rating = vehicle.rate;

          final image = _getVehicleImage(
            imagesPaths: vehicle.imagesPaths,
            vehicleType: vehicleType,
          );

          return Padding(
            padding: EdgeInsets.only(right: RSizes.sm.w),
            child: SizedBox(
              width: cardWidth,
              child: AgencyCarCard(
                image: image,
                name: '$brandName $modelName',
                rating: _vehicleRate(rating),
                seats: '$seats مقاعد',
                price: '$price / ساعة',
                status: status == 'available'
                    ? 'غير مؤجرة'
                    : status == 'maintenance'
                    ? 'صيانة'
                    : 'مؤجرة',
              ),
            ),
          );
        },
      ),
    );
  }

  String _getVehicleImage({
    required List<String>? imagesPaths,
    required String vehicleType,
  }) {
    if (imagesPaths == null || imagesPaths.isEmpty) {
      return _vehicleImage(vehicleType);
    }

    final rawPath = imagesPaths.first;
    final cleanPath = rawPath.replaceAll('\\/', '/').replaceAll('"', '').trim();
    return 'http://10.0.2.2:8000/storage/$cleanPath';
  }

  String _vehicleImage(String type) {
    switch (type) {
      case "سيارة":
        return RImages.car2;
      case "باص":
        return RImages.bus;
      case "دراجة نارية":
        return RImages.motorcycle;
      default:
        return RImages.car1;
    }
  }

  String _vehicleRate(dynamic rate) {
    if (rate == null || rate.toString().isEmpty) return "لم يقيم بعد";
    return rate.toString();
  }
}

