import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RColors.white,
      appBar: AppBar(
        backgroundColor: RColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "الرئيسية",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: RColors.textPrimary,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          "صفحة الرئيسية",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
