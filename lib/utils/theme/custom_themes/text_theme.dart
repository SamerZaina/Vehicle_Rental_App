import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart';

class RTextTheme{
  RTextTheme._();

  static TextTheme lightTextTheme = TextTheme(

      headlineLarge:  const TextStyle().copyWith(fontSize: 64,fontWeight: FontWeight.w400, color: RColors.black,fontFamily:'Tajawal'),
      headlineMedium: const TextStyle().copyWith(color: RColors.primary,fontSize: 24,fontWeight: FontWeight.w400,fontFamily:'Tajawal',),
      headlineSmall: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.normal,color: RColors.black ,fontFamily:'Tajawal'),

      titleLarge: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.bold,color: RColors.primary,letterSpacing: 2,fontFamily: 'Tajawal'),
      titleMedium: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),
      titleSmall: const TextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black),

      bodyLarge: const TextStyle().copyWith(fontSize: 15,fontWeight: FontWeight.w400,color:RColors.primary),
      bodyMedium: const TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black ),
      bodySmall: const TextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black.withOpacity(0.5)),

      labelLarge: const TextStyle().copyWith(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black),
      labelMedium:  const TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black.withOpacity(0.5)),
      labelSmall:  const TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black)

  );
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 64,fontWeight: FontWeight.w400, color: RColors.white,fontFamily:'Tajawal'),
    headlineMedium: const TextStyle().copyWith(color: RColors.primary,fontSize: 24,fontWeight: FontWeight.w600,fontFamily:'Tajawal',),
    headlineSmall: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.normal,color: RColors.light ,fontFamily:'Tajawal'),

    titleLarge: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.bold,color: RColors.primary,letterSpacing: 2,fontFamily: 'Tajawal'),
    titleMedium: const TextStyle().copyWith(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),
    titleSmall: const TextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),

    bodyLarge: const TextStyle().copyWith(fontSize: 15,fontWeight: FontWeight.w400,color:RColors.primary),
    bodyMedium: const TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.white ),
    bodySmall: const TextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.white),
    labelMedium:  const TextStyle().copyWith(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.white.withOpacity(0.5)),

  );

}