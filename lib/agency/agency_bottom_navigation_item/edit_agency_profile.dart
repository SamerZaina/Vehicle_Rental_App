import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/validators/validation.dart';
import 'package:vehicle_rental_app/widgets/login_text_fields.dart';
import '../../customer/data/controllers/user/edit_profile_controller.dart';
import '../../widgets/RAppbar.dart';

class EditAgencyProfile extends StatefulWidget {
  const EditAgencyProfile({super.key});

  @override
  State<EditAgencyProfile> createState() => _EditAgencyProfileState();
}

class _EditAgencyProfileState extends State<EditAgencyProfile> {
  static const Color kIconColor = Color(0xFF767676);

  final controller = Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
  }

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: dark
          ? RAppbarTheme.darkAppBarTheme(
        leadingWidth: 62.w,
        leading: _leadingButton(),
        title: _title(context),
      )
          : RAppbarTheme.lightAppBarTheme(
        leadingWidth: 62.w,
        leading: _leadingButton(),
        title: _title(context),
      ),

      body: SafeArea(
        child: Form(
          key: controller.editFormKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),

            children: [
              SizedBox(height: 20.h),

              // Avatar
              Obx(
                    () => Column(
                  children: [
                    SizedBox(
                      height: 120,
                      width: 100,
                      child: CircleAvatar(
                        backgroundColor: RColors.primary40,
                        backgroundImage:
                        controller.profileImageUrl.value.isNotEmpty
                            ? NetworkImage(controller.profileImageUrl.value)
                            : AssetImage(RImages.user),
                      ),
                    ),
                    TextButton(
                      onPressed: () => controller.pickProfileImage('agency'),
                      child: Text(
                        'تغيير الصورة',
                        style: TextStyle(
                          color: RColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              //NAME
              LoginTextFields(
                controller: controller.nameController,
                hintText: '',
                icon: CupertinoIcons.person,
                validator: (value) => RValidator.validateFullName(value),
              ),

              // PHONE
              LoginTextFields(
                controller: controller.phoneController,
                hintText: '',
                icon: CupertinoIcons.phone,
                validator: (value) => RValidator.validatePhoneNumber(value),
              ),

              //address Field
              LoginTextFields(
                controller: controller.addressController,
                hintText: 'عنوان الوكالة',
                icon: CupertinoIcons.location,
                validator: (value) =>
                    RValidator.validateEmptyText(value, 'عنوان الوكالة'),
              ),
              //commercial register Field
              LoginTextFields(
                controller: controller.commercialRegisterController,
                hintText: 'رخصة الوكالة',
                icon: CupertinoIcons.rectangle_paperclip,
                validator: (value) =>
                    RValidator.validateEmptyText(value, 'رخصة الوكالة'),
              ),

              // Add License
              Obx(() {
                return Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 2,
                    ),
                    child: Center(
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: RColors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: RColors.primary40),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: RColors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: controller.licenseName.value.isEmpty
                              ? 'ملف رخصة الوكالة'
                              : controller.licenseName.value,
                          prefixIcon: IconButton(
                            onPressed: () {
                              controller.pickLicenseFile();
                            },
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                          suffixIcon: const Icon(Icons.description_outlined),
                        ),
                      ),
                    ),
                  ),
                );
              }),

              SizedBox(height: 40.h),

              /// SAVE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.saveUpdates('agency'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    "حفظ",
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable top UI
  Widget _leadingButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(width: 1.w, color: RColors.grey),
      ),
      margin: EdgeInsets.only(right: 5.w),
      child: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(CupertinoIcons.left_chevron),
        color: RColors.darkerGrey,
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      'تعديل بيانات الوكالة',
      style: Theme.of(
        context,
      ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  showOptions(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('اختر صورة من'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(CupertinoIcons.photo),
                title: Text('المعرض'),
                onTap: () => imageFromGallery(context),
              ),
              ListTile(
                leading: Icon(CupertinoIcons.camera),
                title: Text('الكاميرا'),
                onTap: () => imageFromCamera(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future imageFromGallery(BuildContext context) async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
      Navigator.pop(context);
    }
  }

  Future imageFromCamera(BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = image as File;
    });
    Navigator.pop(context);
  }
}
