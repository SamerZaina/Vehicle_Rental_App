import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rental_app/customer/data/controllers/user/user_controller.dart';
import '../../../../utils/loader/loaders.dart';
import '../../repositories/user/user_repository.dart';


class EditProfileController extends GetxController{
  static EditProfileController get instance => Get.find();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final commercialRegisterController =TextEditingController();
  final addressController = TextEditingController();

  PlatformFile? newLicenseFile;
  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  final userController = UserController.instance;
  final repo = UserRepository.instance;
  RxString licenseName = ''.obs;
  final ImagePicker _imagePicker = ImagePicker();
  RxString profileImageUrl = ''.obs;
  final Rx<File?> pickedProfileImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    final user = userController.user;
  if(user != null){
    nameController.text = user.name;
    phoneController.text = user.phone!;
    addressController.text = user.address??'';
    commercialRegisterController.text = user.commercialRegisterNumber??'';
     profileImageUrl.value = user.profilePhotoPath??'';
  }
  }
  // to update file
  Future<void> pickLicenseFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],);
    if (result != null&& result.files.isNotEmpty) {
      newLicenseFile = result.files.single;
      licenseName.value = newLicenseFile!.name;
      Loaders.successSnackBar(
        title: 'تم اختيار الملف',
        message: '${newLicenseFile!.name}',
      );
    } else{
      Loaders.warningSnackBar(
        title: 'فشل اختيار الملف',
        message: '${newLicenseFile!.name}',
      );
    }
    update();
  }

  Future<void> pickProfileImage(String role) async {
    try {
      Get.dialog(
        CupertinoAlertDialog(
          title: Text('اختر مصدر الصورة'),
          actions: [
            CupertinoDialogAction(
              child: Text('المعرض'),
              onPressed: () {
                Get.back();
                _pickImageFromSource(ImageSource.gallery, role);
              },
            ),
            CupertinoDialogAction(
              child: Text('الكاميرا'),
              onPressed: () {
                Get.back();
                _pickImageFromSource(ImageSource.camera,role);
              },
            ),
            CupertinoDialogAction(
              child: Text('إلغاء'),
              onPressed: Get.back,
            ),
          ],
        ),
      );
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'خطأ',
        message: 'فشل في اختيار الصورة: ${e.toString()}',
      );
    }
  }

  Future<void> _pickImageFromSource(ImageSource source , String role) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        pickedProfileImage.value = File(pickedFile.path);
        repo.uploadProfileImageOnly(
            profileImage: pickedProfileImage.value!, role:role );

        update();

        if(pickedProfileImage.value == null) {
          print("image is null after choosing");
        }else {
          print("image not null after choosing");
        }
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'خطأ',
        message: 'فشل في اختيار الصورة: ${e.toString()}',
      );
    }
  }
  Future<void> saveUpdates (String role) async {
    if(!editFormKey.currentState!.validate()) return;
    try{
      if(role=='customer'){
      await repo.updateCustomerProfile(
        name:nameController.text.trim(),
        phone: phoneController.text.trim(),
        drivingLicense :newLicenseFile,
        profileImageFile: pickedProfileImage.value


      );
     Get.back();
      }
      else if(role == 'agency'){
        repo.updateAgencyProfile(
            name: nameController.text.trim(),
            phone: phoneController.text.trim(),
            address: addressController.text.trim(),
          commercialRegister: newLicenseFile ,
          commercialRegisterNum: commercialRegisterController.text.trim(),
          profileImageFile: pickedProfileImage.value

        );
        Get.back();

      } else{
        print('from update $role');
      }
      Loaders.successSnackBar(title: 'تم تعديل بياناتك بنجاح!' );
      await userController.fetchUserData();
    } catch (e){
      Loaders.errorSnackBar(title: 'فشل تحديث البيانات', message: e.toString());
    }
  }


}