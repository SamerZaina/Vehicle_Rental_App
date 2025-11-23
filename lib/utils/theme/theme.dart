import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/screens/login/forget_password.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';

import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/text_theme.dart';


class RAppTheme{
  RAppTheme._();

  static ThemeData LightTheme = ThemeData(
    fontFamily:'Tajawal' ,
    useMaterial3: true,
    focusColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,    //fontFamily: 'LibreBaskerville',
    brightness: Brightness.light,
    primaryColor: RColors.primary,
    scaffoldBackgroundColor: RColors.primaryBackground,
    textTheme: RTextTheme.lightTextTheme,
    chipTheme: RChipTheme.lightChipTheme,
    checkboxTheme: RCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme:RBottomSheetTheme.lightBottomSheetTheme,
    // inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData DarkTheme = ThemeData(
    fontFamily:'Tajawal' ,
    focusColor: Colors.transparent,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: RColors.blackF,
      scrolledUnderElevation: 0,
    ),
    brightness: Brightness.dark,
    primaryColor: RColors.primaryBackground,
    scaffoldBackgroundColor: Colors.black,
    textTheme: RTextTheme.darkTextTheme,
    chipTheme: RChipTheme.darkChipTheme,
    checkboxTheme: RCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: RBottomSheetTheme.darkBottomSheetTheme,



  );
}