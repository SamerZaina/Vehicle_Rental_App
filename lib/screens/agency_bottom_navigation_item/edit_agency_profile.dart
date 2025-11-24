import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';

import '../../utils/refactor_widget/profile_avatar.dart';

class EditAgencyProfile extends StatefulWidget {
  const EditAgencyProfile({super.key});

  @override
  State<EditAgencyProfile> createState() => _EditAgencyProfileState();
}

class _EditAgencyProfileState extends State<EditAgencyProfile> {
  static const Color kIconColor = Color(0xFF767676);

  final TextEditingController nameController = TextEditingController(text: "براءة السيقيلي");
  final TextEditingController emailController = TextEditingController(text: "baraa@example.com");
  final TextEditingController phoneController = TextEditingController(text: "+970 599 123 456");
  final TextEditingController licenseController = TextEditingController(text: "A123456789");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RColors.white,

      appBar: AppBar(
        backgroundColor: RColors.white,
        elevation: 0,
        title: const Text(
          "تعديل الملف الشخصي",
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
              icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),

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
              decoration: BoxDecoration(
                color: RColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: RColors.borderSecondary),
              ),
              child: Column(
                children: [
                  _editableField("الاسم", nameController),
                  _editableField("البريد الإلكتروني", emailController),
                  _editableField("رقم الهاتف", phoneController),
                  _editableField("رخصة القيادة", licenseController),
                  // No divider between fields
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
          ],
        ),
      ),
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
