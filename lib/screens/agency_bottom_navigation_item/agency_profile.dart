import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
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

  // Sample data (you can later replace with API data)
  String agencyName = "اسم الوكالة";
  String agencyEmail = "agency@example.com";
  String agencyPhone = "+970 599 123 456";
  String agencyLicense = "A123456789";
  String imagePath = "assets/images/agency_brand.jpg";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
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
                    // Navigate and wait for new data
                    final updatedData = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditAgencyProfile(
                          name: agencyName,
                          email: agencyEmail,
                          phone: agencyPhone,
                          license: agencyLicense,
                          imagePath: imagePath,
                        ),
                      ),
                    );

                    // Update profile if user saved changes
                    if (updatedData != null) {
                      setState(() {
                        agencyName = updatedData["name"];
                        agencyEmail = updatedData["email"];
                        agencyPhone = updatedData["phone"];
                        agencyLicense = updatedData["license"];
                        imagePath = updatedData["imagePath"];
                      });
                    }
                  },
                ),
              ),

              Expanded(
                child: Center(
                  child: ProfileAvatar(
                    kIconColor: kIconColor,
                    icon: Icons.camera_alt_outlined,
                    imagePath: imagePath,
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
              agencyName,
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
              agencyEmail,
              style: TextStyle(
                fontSize: 16.sp,
                color: RColors.textSecondary,
              ),
            ),
          ),

          SizedBox(height: 35.h),

          // Main info card
          mainInfoCard(true),

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
      ),
    );
  }
}
