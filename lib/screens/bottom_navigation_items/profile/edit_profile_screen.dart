import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vehicle_rental_app/data/controllers/user/edit_profile_controller.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/validators/validation.dart';
import 'package:vehicle_rental_app/widgets/login_text_fields.dart';

import '../../../utils/constants/text_strings.dart';
import '../../../utils/refactor_widget/profile_avatar.dart';
import '../../../widgets/RAppbar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  static const Color kIconColor = Color(0xFF767676);

 final controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: dark ?RAppbarTheme.darkAppBarTheme(
    leadingWidth: 62.w,
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: BoxBorder.all(
                  width: 1.w,
                  color: RColors.grey
              )
          ),
          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
          child: IconButton(
            onPressed: () => Get.back(),
            color: RColors.darkerGrey, icon: Icon(CupertinoIcons.left_chevron),
          ),
        ),
        title: Text('تعديل الملف الشخصي' ,
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(
              fontWeight: FontWeight.bold
          ),),

    ) : RAppbarTheme.lightAppBarTheme(
    leadingWidth: 62.w,
    leading: Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    border: BoxBorder.all(
    width: 1.w ,
    color: RColors.grey
    )
    ),
    margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
    child: IconButton(
      onPressed: () => Get.back(),
    color: RColors.darkerGrey, icon:Icon( CupertinoIcons.left_chevron),
    ),
    ) ,
    title: Text('تعديل الملف الشخصي' ,
    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
    fontSize:20.sp,
    fontWeight: FontWeight.bold
    ),),

    ) ,
    body: SafeArea(
    child: ListView(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    children: [
    const SizedBox(height: 20),
      // Avatar
      Obx( () => Column(
        children: [
          SizedBox(
            height: 120,
            width: 100,
            child: CircleAvatar(
                backgroundColor: RColors.primary40,
                backgroundImage: controller.profileImageUrl.value.isNotEmpty
                    ? NetworkImage(controller.profileImageUrl.value)
                    : AssetImage(RImages.user)
            ),
          ),
          TextButton(
              onPressed: ()=>controller.pickProfileImage('agency'),
              child: Text('تغيير الصورة' ,
                  style: TextStyle(
                    color: RColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,

                  )) ),
        ],
      ),
      ),




      const SizedBox(height: 30),

    // Editable Info Card (without divider lines)
    Container(
    margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
    decoration: BoxDecoration(
   // color: RColors.white,
    borderRadius: BorderRadius.circular(16),
    //  border: Border.all(color: RColors.borderSecondary),
    ),
    child: Form(
      key: controller.editFormKey,
      child: Column(
      children: [
      LoginTextFields(
      controller: controller.nameController,
      hintText: "",
      icon: CupertinoIcons.person,
      validator: (value)=> RValidator.validateFullName(value)) ,

      LoginTextFields(
      controller: controller.phoneController,
      hintText: "",
      icon: CupertinoIcons.phone,
      validator: (value)=> RValidator.validatePhoneNumber(value)) ,

      ],
      ),
    ),
    ),
      Obx(() {
        return Container(
          margin: EdgeInsets.fromLTRB(5, 0,0, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18,
            vertical: 2),
            child: Center(
              child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: RColors.white,
                     border: OutlineInputBorder(
                       borderSide: BorderSide(
                         color: RColors.primary40,

                       ),
                       borderRadius: BorderRadius.circular(8),
                     ),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: RColors.grey,

                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: controller.licenseName.value.isEmpty
                        ? RTexts.drivingLicense
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
    const SizedBox(height: 40),

    // Save Button
    SizedBox(
    width: double.infinity,
    child: ElevatedButton(
    onPressed: ()=> controller.saveUpdates('customer'),
    style: ElevatedButton.styleFrom(
    backgroundColor: RColors.primary,
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    ),
    ),
    child: const Text(
    "حفظ",
    style: TextStyle(fontSize: 18, color: Colors.white),
    ),
    ),
    ),

    const SizedBox(height: 30),
    ]
    ,
    )
    ,
    )
    ,
    );
  }

}
