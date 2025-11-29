import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/validators/validation.dart';
import 'package:vehicle_rental_app/widgets/login_text_fields.dart';

import '../../utils/refactor_widget/profile_avatar.dart';
import '../../widgets/RAppbar.dart';

class EditAgencyProfile extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String license;
  final String imagePath;

  const EditAgencyProfile({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.license,
    required this.imagePath,
  });

  @override
  State<EditAgencyProfile> createState() => _EditAgencyProfileState();
}

class _EditAgencyProfileState extends State<EditAgencyProfile> {
  static const Color kIconColor = Color(0xFF767676);

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController licenseController;

  TextEditingController fileController = TextEditingController();
  String? selectedFilePath;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    licenseController = TextEditingController(text: widget.license);
  }

  Future<void> pickFile() async {
    final file = await FilePicker.platform.pickFiles();

    if (file != null) {
      setState(() {
        selectedFilePath = file.files.single.path!;
        fileController.text = file.files.single.name;
      });
    }
  }



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
        child: ListView(

          padding: EdgeInsets.symmetric(horizontal: 20.w),

          children: [
            SizedBox(height: 20.h),

            /// Avatar
            ProfileAvatar(
              kIconColor: kIconColor,
              icon: Icons.camera_alt_outlined,
              imagePath: widget.imagePath,
            ),

            SizedBox(height: 30.h),

            /// NAME
            LoginTextFields(
              controller: nameController,
              hintText: widget.name,
              icon: CupertinoIcons.person,
              validator: (value) => RValidator.validateFullName(value),
            ),

            /// EMAIL FIXED HEIGHT
            emailField(),

            /// PHONE
            LoginTextFields(
              controller: phoneController,
              hintText: widget.phone,
              icon: CupertinoIcons.phone,
              validator: (value) => RValidator.validatePhoneNumber(value),
            ),

            /// LICENSE
            LoginTextFields(
              controller: licenseController,
              hintText: widget.license,
              icon: CupertinoIcons.rectangle_paperclip,
              validator: (value) => RValidator.validateFullName(value),
            ),

            /// FILE PICKER
            filePickerField(),

            SizedBox(height: 40.h),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.snackbar(
                    "نجاح",
                    "تم تعديل بيانات الوكالة بنجاح!",
                    backgroundColor: RColors.primary,
                    colorText: Colors.white,
                    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    duration: const Duration(seconds: 2),
                    borderRadius: 12,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
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
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget emailField() {
    final dark = RHelperFunctions.isDarkMode(context);
    return Container(
      margin: EdgeInsets.fromLTRB(25.w, 0, 0, 12.h),
      width: 400.w,
      height: 60.h,
      child: TextFormField(
        controller: emailController,
        readOnly: true,
        enabled: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: widget.email,
          hintStyle: TextStyle(color: RColors.primary40, fontSize: 16.sp),
          prefixIcon: Icon(CupertinoIcons.mail, color: RColors.primary40),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: RColors.grey,
                width: 0.8.w,
              )
          ),

          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: RColors.grey,
                width: 0.8.w,
              )
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        ),
      ),
    );
  }


  Widget filePickerField() {
    return Container(
      margin: EdgeInsets.fromLTRB(25.w, 0, 0, 12.h),
      width: 400.w,
      height: 60.h,
      child: TextFormField(
        controller: fileController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "اختر ملف الترخيص",
          hintStyle: TextStyle(color: RColors.primary40, fontSize: 16.sp),
          prefixIcon: IconButton(
            icon: Icon(CupertinoIcons.add_circled, color: RColors.primary40),
            onPressed: pickFile,
          ),
          filled: true,
          fillColor: RColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: RColors.grey, width: .8.w),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: RColors.grey,
                width: 0.8.w,
              )
          ),
          focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: RColors.primary40,
                width: 0.8.w,
              )
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        ),
      ),
    );
  }
}
