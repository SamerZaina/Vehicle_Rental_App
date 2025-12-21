import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vehicle_rental_app/data/controllers/user/user_controller.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/refactor_widget/profile_main_info_card.dart';
import '../../utils/refactor_widget/logout_dialog.dart';
import '../../utils/refactor_widget/profile_avatar.dart';
import 'edit_agency_profile.dart';

class AgencyProfile extends StatefulWidget {
  const AgencyProfile({super.key});

  @override
  State<AgencyProfile> createState() => _AgencyProfileState();
}

class _AgencyProfileState extends State<AgencyProfile> {
  static const Color kIconColor = Color(0xFF767676);
  final userController = UserController.instance;

  @override
  void initState() {
    super.initState();
    if (userController.user == null) {
      userController.fetchUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Obx(() {
      final user = userController.user;

      if (user == null) {
        return Center();
      }
      return SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // EDIT BUTTON
                Container(
                  width: 58.w,
                  height: 58.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: RColors.white,
                    border: Border.all(width: 1.w, color: RColors.grey),
                  ),
                  child: IconButton(
                    icon: Icon(
                      CupertinoIcons.pencil,
                      color: RColors.darkerGrey,
                      size: 24.sp,
                    ),
                    onPressed: () => Get.to(() => EditAgencyProfile()),
                  ),
                ),
                // Avatar
                Center(
                  child: Obx(
                        () => SizedBox(
                      height: 120,
                      width: 100,
                      child: CircleAvatar(
                        backgroundColor: RColors.primary40,
                        backgroundImage: userController.profileImageUrl.value.isNotEmpty
                            ? NetworkImage(userController.profileImageUrl.value)
                            : AssetImage(RImages.user),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 58.w, height: 58.w),
              ],
            ),

            SizedBox(height: 20.h),
            // Agency Name
            Center(
              child: Text(
                user.name,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: RColors.textPrimary,
                ),
              ),
            ),

            SizedBox(height: 5.h),

            // Email
            Center(
              child: Text(
                user.email,
                style: TextStyle(fontSize: 16.sp, color: RColors.textSecondary),
              ),
            ),

            SizedBox(height: 35.h),

            // Main info card
            Container(
              decoration: BoxDecoration(
                color: RColors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: RColors.borderSecondary),
              ),
              child: Column(
                children: [
                  _infoTile(Icons.phone_outlined, "رقم الهاتف", user.phone!),
                  Divider(
                    indent: 20.w,
                    endIndent: 20.w,
                    color: RColors.borderPrimary,
                  ),
                  _infoTile(
                    Icons.credit_card_outlined,
                    "رخصة الوكالة",
                    user.commercialRegister == null ? 'غير مرفق :' : 'مرفق',
                  ),
                  Divider(
                    indent: 20.w,
                    endIndent: 20.w,
                    color: RColors.borderPrimary,
                  ),
                  _infoTile(
                    Icons.verified_user_outlined,
                    "الحالة",
                    user.isApproved == true ? "مفعل" : "غير مفعل",
                    valueColor: user.isApproved == true
                        ? Colors.green
                        : Colors.red,
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            // Logout Button
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.logout, size: 20,),
                  TextButton(
                    onPressed: ()=>showLogoutDialog(context),
                    child: Text('تسجيل خروج',
                      style: TextStyle(
                          color: dark ? RColors.white : RColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp
                      ),),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      );
    });
  }

  Widget _infoTile(
      IconData icon,
      String title,
      String value, {
        Color? valueColor,
      }) {
    Color? kIconColor;
    return ListTile(
      leading: Icon(icon, color: kIconColor, size: 26.r),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
          color: RColors.textPrimary,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontSize: 14.sp,
          color: valueColor ?? RColors.textSecondary,
        ),
      ),
    );
  }
}
