import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/validators/validation.dart';
import 'package:vehicle_rental_app/widgets/login_text_fields.dart';

import '../../../utils/refactor_widget/profile_avatar.dart';
import '../../../widgets/RAppbar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  static const Color kIconColor = Color(0xFF767676);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();

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

    // Profile Image
    ProfileAvatar(kIconColor: kIconColor
    , icon: Icons.camera_alt_outlined,
    imagePath: "assets/images/women.png",
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
    child: Column(
    children: [
    LoginTextFields(
    controller: nameController,
    hintText: "براءة السيقلي",
    icon: CupertinoIcons.person,
    validator: (value)=> RValidator.validateFullName(value)) ,
    LoginTextFields(
    controller: emailController,
    hintText: "baraa@example.com",
    icon: CupertinoIcons.mail,
    validator: (value)=> RValidator.validateEmail(value)) ,
    LoginTextFields(
    controller: phoneController,
    hintText: "+9725963265456",
    icon: CupertinoIcons.phone,
    validator: (value)=> RValidator.validatePhoneNumber(value)) ,
    LoginTextFields(
    controller: licenseController,
    hintText: "A126656596",
    icon: CupertinoIcons.rectangle_paperclip,
    validator: (value)=> RValidator.validatePhoneNumber(value)) ,


    ],
    ),
    ),

    const SizedBox(height: 40),

    // Save Button
    SizedBox(
    width: double.infinity,
    child: ElevatedButton(
    onPressed: () {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: const Text(
    "تم تعديل البيانات بنجاح!",
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
    ),
    backgroundColor: RColors.primary,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    ),
    ),
    );
    },
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

  Widget _editableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: kIconColor),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: RColors.primary),
          ),
        ),
      ),
    );
  }
}
