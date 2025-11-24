import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';

import '../../screens/login/login_screen.dart';
void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      Color? kIconColor;
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