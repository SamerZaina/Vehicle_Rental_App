import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:vehicle_rental_app/screens/login/login_screen.dart';

import '../../app_start_controller.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

// Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update current Index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  // Jump to the specific dot selected
  void dotClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  // Update index and go to the next page
  void nextPage() {
    if (currentPageIndex.value == 0) {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }else if (currentPageIndex.value == 1) {
      AppStartController.to.finishOnBoarding();
    }
    else{
     Get.to(LoginScreen());
    }
  }
}
