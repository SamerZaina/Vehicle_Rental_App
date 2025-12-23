import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/network/network_manager.dart';
import 'package:vehicle_rental_app/widgets/navigation_menu.dart';

import '../../../../agency/agency_bottom_navigation_item/bottom_navigation.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/loader/loaders.dart';
import '../../models/user/user_model.dart';
import '../../repositories/authentication/authentication_repository.dart';


class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  // Auth repository
  final authenticationRepository = AuthenticationRepository.instance;

  // Variables
  final hidePassword = true.obs;
  RxString licenseName = ''.obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final phoneNumController = TextEditingController();
  PlatformFile? licenseFile;

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  void customerRegister() async {
    try {
      //Form Validation
      if (!registerFormKey.currentState!.validate()) return;
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
      final UserModel user;
        // save record as customer
        user = await authenticationRepository.registerCustomer(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneNumController.text.trim(),
          password: passwordController.text.trim(),
          passwordConfirmation: passwordConfirmationController.text.trim(),
          drivingLicenseFile: licenseFile,
        );


      RHelperFunctions.stopLoading();
      Loaders.successSnackBar(title: 'تم بنجاح', message: 'تم انشاء حسابك');
      if (user.isCustomer) {
        Get.to(() => NavigationMenu());
      } else if (user.isAgency) {
        Get.to(() => BottomNavigation());
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'حدث خطأ ما', message: e.toString());
      RHelperFunctions.stopLoading();
    }
  }

  Future<void> pickDrivingLicense() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      licenseFile = result.files.first;
      licenseName.value = licenseFile!.name;

      Loaders.successSnackBar(
        title: 'تم اختيار الملف',
        message: '${licenseFile!.name}',
      );
    } else {
      Loaders.warningSnackBar(
        title: 'فشل اختيار الملف',
        message: '${licenseFile!.name}',
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.onClose();
  }

  //final userController = UserController.instance;
}

class AgencyRegisterController extends GetxController {
  static AgencyRegisterController get instance => Get.find();

  // Auth repository
  final authenticationRepository = AuthenticationRepository.instance;

  // Variables
  final hidePassword = true.obs;
  RxString licenseName = ''.obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final commercialRegisterController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final phoneNumController = TextEditingController();
  PlatformFile? licenseFile;

   GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  void agencyRegister() async {
    try {
      //Form Validation
      if (!registerFormKey.currentState!.validate()) return;
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
      final UserModel user;

        // save record as agency
        user = await authenticationRepository.registerAgency(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneNumController.text.trim(),
          password: passwordController.text.trim(),
          address: addressController.text.trim(),
          passwordConfirmation: passwordConfirmationController.text.trim(),
          commercialRegisterNumber: commercialRegisterController.text.trim(),
          commercialLicenseFile: licenseFile
        );


      RHelperFunctions.stopLoading();
      Loaders.successSnackBar(title: 'تم بنجاح', message: 'تم انشاء حسابك');
      if (user.isCustomer) {
        Get.to(() => NavigationMenu());
      } else if (user.isAgency) {
        Get.to(() => BottomNavigation());
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'حدث خطأ ما', message: e.toString());
      RHelperFunctions.stopLoading();
    }
  }
  Future<void> pickLicense() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      licenseFile = result.files.first;
      licenseName.value = licenseFile!.name;

      Loaders.successSnackBar(
        title: 'تم اختيار الملف',
        message: '${licenseFile!.name}',
      );
    } else {
      Loaders.warningSnackBar(
        title: 'فشل اختيار الملف',
        message: '${licenseFile!.name}',
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.onClose();
  }

//final userController = UserController.instance;
}

