import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/screens/bottom_navigation_items/edit_profile_screen.dart';
import 'package:vehicle_rental_app/screens/login/login_screen.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';

import '../../utils/refactor_widget/profile_avatar.dart';

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
    return Scaffold(
      backgroundColor: RColors.white,

      appBar: AppBar(
        backgroundColor: RColors.white,
        elevation: 0,
        title: const Text(
          "الملف الشخصي",
          style: TextStyle(
            color: Color(0xFF000000),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kIconColor),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kIconColor),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 22,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfile()),
                  );
                },
              ),
            ),
          ),
        ],
      ),

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
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout_outlined),
                label: const Text(
                  "تسجيل الخروج",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () => _showLogoutDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: RColors.error,
                  foregroundColor: RColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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

  // ---------- Styled Logout Confirmation Dialog ----------
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: RColors.white, // dialog background
          title: Text(
            "تسجيل الخروج",
            style: TextStyle(
              color: RColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Text(
            "هل أنت متأكد من تسجيل الخروج؟",
            style: TextStyle(
              color: RColors.textSecondary,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close dialog
              },
              child: Text(
                "لا",
                style: TextStyle(
                  color: kIconColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: Text(
                "نعم",
                style: TextStyle(
                  color: RColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


