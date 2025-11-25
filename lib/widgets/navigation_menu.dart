import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vehicle_rental_app/screens/bottom_navigation_items/home_screen.dart';
import 'package:vehicle_rental_app/screens/bottom_navigation_items/profile/profile_screen.dart';
import 'package:vehicle_rental_app/screens/bottom_navigation_items/wish_list.dart';
import 'package:vehicle_rental_app/utils/constants/sizes.dart';
import '../screens/bottom_navigation_items/agencies/agancies_screen.dart';
import '../utils/constants/colors.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      body: Stack(
          children: [
            Obx(() => controller.screens[controller.selectedIndex.value]),
            Positioned(
              bottom: 0,
              left:20 ,
              right: 20,
              child: Obx(
                    () => Container(
                  width:400.w,
                  height: 70.h,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  decoration: BoxDecoration(
                    color: RColors.primary,
                    borderRadius: BorderRadius.circular(50.r),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNavItem(
                          icon: Iconsax.home_2_copy,
                          index: 0,
                          controller: controller,
                        ),
                        SizedBox(width: RSizes.spaceBtwItems*3.w),
                        _buildNavItem(
                          icon: Iconsax.heart_copy,
                          index: 1,
                          controller: controller,
                        ),
                        SizedBox(width: RSizes.spaceBtwItems*3.w),
                        _buildNavItem(
                          icon: CupertinoIcons.square_list,
                          index: 2,
                          controller: controller,
                        ),
                        SizedBox(width: RSizes.spaceBtwItems*3.w),
                        _buildNavItem(
                          icon: Iconsax.category_2_copy,
                          index: 3,
                          controller: controller,
                        ),
                        SizedBox(width: RSizes.spaceBtwItems*3.w),
                        _buildNavItem(
                          icon: Iconsax.user_copy,
                          index: 4,
                          controller: controller,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ]
      ) ,

    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required NavigationController controller,
  }) {
    bool isSelected = controller.selectedIndex.value == index;
    return GestureDetector(
      onTap: () {
        controller.selectedIndex.value = index;

      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? RColors.light : RColors.darkGrey,
            size: 22.sp,
          ),
          SizedBox(height: 3.h,),
          Container(
            width: 20.w,
            height: 1.h,
            decoration: BoxDecoration(
              color: isSelected ? RColors.light : Colors.transparent,
              borderRadius: BorderRadius.circular(1.r),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [Home(), WishList(), Container(), AganciesScreen(),Profile()];

  void changePage(int index) {
    selectedIndex.value = index;
  }

  void goToHome() {
    selectedIndex.value = 0;
  }

}
