import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/data/repositories/authentication/authentication_repository.dart';
import 'package:vehicle_rental_app/screens/agency_bottom_navigation_item/bottom_navigation.dart';
import 'package:vehicle_rental_app/widgets/navigation_menu.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/loader/loaders.dart';
import '../../../utils/network/network_manager.dart';
import '../user/user_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // auth repo
  final authenticationRepository = AuthenticationRepository.instance;

  // variables
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final secureStorage = FlutterSecureStorage();

  @override
  void onInit() async {
    emailController.text =
        await secureStorage.read(key: 'remember_email') ?? '';
    passwordController.text =
        await secureStorage.read(key: 'remember_password') ?? '';
    super.onInit();
  }

  // login function
  Future<void> loginUser() async {
    try {
      //Form Validation
      if (!loginFormKey.currentState!.validate()) return;
      // check the internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Loaders.errorSnackBar(
          title: 'لا يوجد انترنت',
          message: 'تحقق من اتصالك و اعد المحاولة ثانيةً!',
        );
        return;
      }
      // open loader
      RHelperFunctions.openLoadDialog(
        'جاري تسجيل بيانات المستخدم...',
        RImages.loader,
      );

      if (rememberMe.value) {
        secureStorage.write(
          key: 'remember_email',
          value: emailController.text.trim(),
        );
        secureStorage.write(
          key: 'remember_password',
          value: passwordController.text.trim(),
        );
      }
      final user = await authenticationRepository.loginWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
       print('from login ${user.role} ');
      UserController.instance.setUser(user);

      if (user.isAgency) {
        Get.offAll(() => BottomNavigation());
      } else if (user.isCustomer) {
        Get.offAll(() => NavigationMenu());
      } else {
        return;
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'حدث خطأ ما', message: e.toString());
      RHelperFunctions.stopLoading();
    }
  }
}
