import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';

class RChipTheme {
  RChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
      disabledColor: Colors.grey.withOpacity(0.4),
      labelStyle: const TextStyle(color: Colors.black),
      selectedColor: RColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      checkmarkColor: Colors.white
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
      disabledColor: Colors.grey,
      labelStyle: const TextStyle(color: Colors.white),
      selectedColor: RColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      checkmarkColor: Colors.white
  );
}