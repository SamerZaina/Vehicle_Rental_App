import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vehicle_rental_app/data/repositories/authentication/authentication_repository.dart';
import 'package:vehicle_rental_app/screens/login/login_screen.dart';
import 'package:vehicle_rental_app/screens/on_boarding/onBoarding.dart';

class AppStartController extends GetxController {
  static AppStartController get to => Get.find<AppStartController>();

  final deviceStorage = GetStorage();

  @override
  void onReady() {
    super.onReady();
    _screenRedirect();
  }

  Future<void> _screenRedirect() async {
    deviceStorage.writeIfNull('isFirstTime', true);
    final isFirstTime = deviceStorage.read('isFirstTime') as bool;

    if (kDebugMode) {
      print('--------- AppStartController ---------');
      print('isFirstTime = $isFirstTime');
    }

    if (isFirstTime) {
      Get.offAll(() => const Onboarding());
    } else {
      AuthenticationRepository.instance.redirect();
    }
  }

  void finishOnBoarding() {
    deviceStorage.write('isFirstTime', false);
    Get.offAll(() => const LoginScreen());
  }
}