import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/refactor_widget/logout_dialog.dart';
import '../../../utils/refactor_widget/profile_avatar.dart';
import '../../../widgets/RAppbar.dart';
import '../../data/controllers/user/user_controller.dart';
import 'edit_profile_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static const Color kIconColor = Color(0xFF767676);

  final userController = UserController.instance;
  var profileImageUrl =''.obs;

  // Status variable
  @override
  void initState(){
    super.initState();
    if(userController.user == null){
      userController.fetchUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Obx( (){
      final user = userController.user;
       profileImageUrl.value = user?.profilePhotoPath ??'';

      if (user == null){
        return Center(child: Text(''));
      }
        return Scaffold(
          appBar: dark ? RAppbarTheme.darkAppBarTheme(
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
                  onPressed: () {},
                  color: RColors.darkerGrey,
                  icon: Icon(CupertinoIcons.left_chevron),
                ),
              ),
              title: Text('الملف الشخصي',
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(
                    fontWeight: FontWeight.bold
                ),),
              actions: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: BoxBorder.all(
                          width: 1.w,
                          color: RColors.grey
                      )
                  ),
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: IconButton(
                    onPressed: () => Get.to(EditProfile()),
                    color: RColors.darkerGrey, icon: Icon(Icons.edit,),
                  ),
                ),
              ]
          )
              : RAppbarTheme.lightAppBarTheme(
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
                  onPressed: () {},
                  color: RColors.darkerGrey,
                  icon: Icon(CupertinoIcons.left_chevron),
                ),
              ),
              title: Text('الملف الشخصي',
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(
                    fontSize: 20.sp,
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
                      icon: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: () => Get.to(EditProfile()),
                    ),
                  ),
                ),
              ]
          ),
          body: SafeArea(
            child: ListView(
              padding:  EdgeInsets.symmetric(horizontal: 20),
              children: [
                 SizedBox(height: 20),
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
                        onPressed: () => Get.to(() => EditProfile()),
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

                SizedBox(height: 15),
                Center(
                  child: Text(user.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: RColors.textPrimary,
                    ),
                  ),
                ),

                SizedBox(height: 5),

                Center(
                  child: Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 16,
                      color: RColors.textSecondary,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                Container(
                  decoration: BoxDecoration(
                    color: RColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: RColors.borderSecondary),
                  ),
                  child: Column(
                    children: [
                      _infoTile(Icons.phone_outlined, "رقم الهاتف",user.phone! ),
                      _divider(),
                      _infoTile(Icons.credit_card_outlined, "رخصة القيادة", user.drivingLicense == null ? 'غير مرفق' : ' مرفق'),
                      _divider(),
                      _infoTile(
                        Icons.verified_user_outlined,
                        "الحالة",
                        user.isApproved == true ? "مفعل" : "غير مفعل",
                        valueColor: user.isApproved == true ? Colors.green : Colors.red,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

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

                const SizedBox(height: 30),
              ],
            ),)
          ,
        );}
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


