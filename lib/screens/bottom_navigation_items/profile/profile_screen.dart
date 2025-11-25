import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vehicle_rental_app/screens/bottom_navigation_items/profile/edit_profile_screen.dart';
import 'package:vehicle_rental_app/screens/login/login_screen.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';

import '../../../utils/refactor_widget/logout_dialog.dart';
import '../../../utils/refactor_widget/profile_avatar.dart';
import '../../../widgets/RAppbar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static const Color kIconColor = Color(0xFF767676);

  // Status variable
  bool status = false;

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
                    width: 1.w ,
                    color: RColors.grey
                )
            ),
            margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: IconButton(
              onPressed: (){},
              color: RColors.darkerGrey, icon:Icon( CupertinoIcons.left_chevron),
            ),
          ) ,
          title: Text('الملف الشخصي' ,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold
            ),),
          actions: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: BoxBorder.all(
                      width: 1.w ,
                      color: RColors.grey
                  )
              ),
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: IconButton(
                onPressed:()=> Get.to(EditProfile()) ,
                color: RColors.darkerGrey, icon:Icon( Icons.edit,),
              ),
            ) ,
          ]
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
              onPressed: (){},
              color: RColors.darkerGrey, icon:Icon( CupertinoIcons.left_chevron),
            ),
          ) ,
          title: Text('الملف الشخصي' ,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize:20.sp,
                fontWeight: FontWeight.bold
            ),),
          actions: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: RColors.darkGrey),
                ),
                child: IconButton(
                  icon:  Icon(
                  Icons.edit,
                    size: 20,
                    color: Colors.grey,
                  ),
                  onPressed:()=> Get.to(EditProfile()) ,
                ),
              ),
            ),
          ]
      ) ,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 20),
            ProfileAvatar(kIconColor: kIconColor
              , icon: Icons.camera_alt_outlined,
              imagePath: "assets/images/women.png",
            ),

            const SizedBox(height: 15),

            const Center(
              child: Text(
                "براءة السيقلي",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: RColors.textPrimary,
                ),
              ),
            ),

            const SizedBox(height: 5),

            const Center(
              child: Text(
                "baraa@example.com",
                style: TextStyle(
                  fontSize: 16,
                  color: RColors.textSecondary,
                ),
              ),
            ),

            const SizedBox(height: 35),

            _mainInfoCard(),

            const SizedBox(height: 40),

            SizedBox(
              width:150,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout_outlined),
                label: const Text(
                  "تسجيل الخروج",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () => showLogoutDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: RColors.error,
                  foregroundColor: RColors.white,
                  padding:  EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _mainInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: RColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RColors.borderSecondary),
      ),
      child: Column(
        children: [
          _infoTile(Icons.phone_outlined, "رقم الهاتف", "+970 599 123 456"),
          _divider(),
          _infoTile(Icons.credit_card_outlined, "رخصة القيادة", "A123456789"),
          _divider(),
          _infoTile(
            Icons.verified_user_outlined,
            "الحالة",
            status == true ? "مفعل" : "غير مفعل",
            valueColor: status == true ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value, {Color? valueColor}) {
    return ListTile(
      leading: Icon(icon, color: kIconColor, size: 26),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: RColors.textPrimary,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontSize: 14,
          color: valueColor ?? RColors.textSecondary,
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      indent: 20,
      endIndent: 20,
      color: RColors.borderPrimary,
    );
  }

}


