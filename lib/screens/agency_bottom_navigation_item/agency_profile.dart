// import 'package:flutter/cupertino.dart' show CupertinoIcons;
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vehicle_rental_app/utils/constants/colors.dart';
// import 'package:vehicle_rental_app/utils/refactor_widget/profile_main_info_card.dart';
// import '../../utils/refactor_widget/logout_dialog.dart';
// import '../../utils/refactor_widget/profile_avatar.dart';
// import 'edit_agency_profile.dart';
//
// class AgencyProfile extends StatefulWidget {
//   const AgencyProfile({super.key});
//
//   @override
//   State<AgencyProfile> createState() => _AgencyProfileState();
// }
//
// class _AgencyProfileState extends State<AgencyProfile> {
//   static const Color kIconColor = Color(0xFF767676);
//
//   // Sample data (you can later replace with API data)
//   String agencyName = "اسم الوكالة";
//   String agencyEmail = "agency@example.com";
//   String agencyPhone = "+970 599 123 456";
//   String agencyLicense = "A123456789";
//   String imagePath = "assets/images/agency_brand.jpg";
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ListView(
//         padding: EdgeInsets.symmetric(horizontal: 20.w),
//         children: [
//           SizedBox(height: 20.h),
//
//           // ---------------------- ROW: Edit + Avatar ----------------------
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // EDIT BUTTON
//               Container(
//                 width: 58.w,
//                 height: 58.w,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30.r),
//                   color: RColors.white,
//                   border: Border.all(
//                     width: 1.w,
//                     color: RColors.grey,
//                   ),
//                 ),
//                 child: IconButton(
//                   icon: Icon(
//                     CupertinoIcons.pencil,
//                     color: RColors.darkerGrey,
//                     size: 24.sp,
//                   ),
//                   onPressed: () async {
//                     // Navigate and wait for new data
//                     final updatedData = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => EditAgencyProfile(
//                           name: agencyName,
//                           email: agencyEmail,
//                           phone: agencyPhone,
//                           license: agencyLicense,
//                           imagePath: imagePath,
//                         ),
//                       ),
//                     );
//
//                     // Update profile if user saved changes
//                     if (updatedData != null) {
//                       setState(() {
//                         agencyName = updatedData["name"];
//                         agencyEmail = updatedData["email"];
//                         agencyPhone = updatedData["phone"];
//                         agencyLicense = updatedData["license"];
//                         imagePath = updatedData["imagePath"];
//                       });
//                     }
//                   },
//                 ),
//               ),
//
//               Expanded(
//                 child: Center(
//                   child: ProfileAvatar(
//                     kIconColor: kIconColor,
//                     icon: Icons.camera_alt_outlined,
//                     imagePath: imagePath,
//                   ),
//                 ),
//               ),
//
//               SizedBox(width: 58.w, height: 58.w),
//             ],
//           ),
//
//           SizedBox(height: 20.h),
//
//           // Agency Name
//           Center(
//             child: Text(
//               agencyName,
//               style: TextStyle(
//                 fontSize: 22.sp,
//                 fontWeight: FontWeight.bold,
//                 color: RColors.textPrimary,
//               ),
//             ),
//           ),
//
//           SizedBox(height: 5.h),
//
//           // Email
//           Center(
//             child: Text(
//               agencyEmail,
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 color: RColors.textSecondary,
//               ),
//             ),
//           ),
//
//           SizedBox(height: 35.h),
//
//           // Main info card
//           mainInfoCard(true),
//
//           SizedBox(height: 40.h),
//
//           // Logout Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton.icon(
//               icon: const Icon(Icons.logout_outlined),
//               label: Text(
//                 "تسجيل الخروج",
//                 style: TextStyle(fontSize: 18.sp),
//               ),
//               onPressed: () => showLogoutDialog(context),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: RColors.primary,
//                 foregroundColor: RColors.white,
//                 padding: EdgeInsets.symmetric(vertical: 14.h),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(24.r),
//                 ),
//               ),
//             ),
//           ),
//
//           SizedBox(height: 30.h),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/api_service/api_service.dart';
import 'package:vehicle_rental_app/controller/agency_profile_controller.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/refactor_widget/profile_main_info_card.dart';
import '../../controller/agency_profile_controller.dart';
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

  final AgencyProfileModelController controller =
  Get.put(AgencyProfileModelController());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {

        // ✅ Loading
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }


        // ✅ Error
        // here if there's error like unauthenticated , it will
        // print at the center of the screen .
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: TextStyle(color: Colors.red, fontSize: 16.sp),
            ),
          );
        }

        // ✅ No data
        if (controller.agencyProfile.value == null) {
          return const Center(child: Text('No profile data'));
        }

        final agency = controller.agencyProfile.value!;

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            SizedBox(height: 20.h),

            // ---------------------- ROW: Edit + Avatar ----------------------
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
                    border: Border.all(
                      width: 1.w,
                      color: RColors.grey,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      CupertinoIcons.pencil,
                      color: RColors.darkerGrey,
                      size: 24.sp,
                    ),
                    onPressed: () async {
                      final updatedData = await Navigator.push(
                        context,
                        // this will be passed to edit agency profile
                        MaterialPageRoute(
                          builder: (_) => EditAgencyProfile(
                            name: agency.agencyName,
                            email: agency.email,
                            phone: agency.phone,
                            license: agency.commercialRegister ?? 'No License',
                            imagePath: agency.profileImage ?? 'assets/images/agency_brand.jpg',
                          ),
                        ),
                      );

                      // ✅ Refresh profile after edit
                      if (updatedData != null) {
                        controller.fetchAgencyProfile();
                      }
                    },
                  ),
                ),

                Expanded(
                  child: Center(
                    child: ProfileAvatar(
                      kIconColor: kIconColor,
                      icon: Icons.camera_alt_outlined,
                      imagePath: agency.profileImage ?? 'assets/images/agency_brand.jpg',
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
                agency.agencyName,
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
                agency.email,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: RColors.textSecondary,
                ),
              ),
            ),

            SizedBox(height: 35.h),

            // Main info card (you can refactor to pass agency later)
            mainInfoCard(agency.phone,
                agency.commercialRegister ?? "رجاء ادخل رقم الرخصة",
                true
                ),


            SizedBox(height: 40.h),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout_outlined),
                label: Text(
                  "تسجيل الخروج",
                  style: TextStyle(fontSize: 18.sp),
                ),
                onPressed: () => showLogoutDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: RColors.primary,
                  foregroundColor: RColors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.h),
          ],
        );
      }),
    );
  }
}
