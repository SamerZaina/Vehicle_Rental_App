import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants/colors.dart';
import '../utils/helpers/helper_functions.dart';

class LoginTextFields extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final String? Function(String?) validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;

  const LoginTextFields({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);

    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.fromLTRB(25.w, 0, 0, 12.h),
      width: 400.w,
      height: 60.h,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          filled: true,
          fillColor:  dark ? RColors.primary70:RColors.white ,
          hintText: hintText,
          hintStyle: TextStyle(color: RColors.primary40, fontSize: 16.sp),
          prefixIcon: Icon(icon, color: RColors.primary40),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: RColors.grey,
                width: 0.8.w,
            )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: RColors.grey,
                width: 0.8.w,
              )
          ),
          focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: RColors.primary40,
                width: 0.8.w,
              )
          ),
          errorBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: RColors.error,
                width: 0.8.w,
              )
          ),
          focusedErrorBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: RColors.error,
                width: 0.8.w,
              )
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical:16.h),
          errorStyle: TextStyle(
            color: RColors.error,
            fontSize: 12.sp,
            height: 1.5.h,
          ),
        ),
      ),
    );
  }
}