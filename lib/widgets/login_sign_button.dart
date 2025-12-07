import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';

import '../utils/constants/colors.dart';

class LoginSignButton extends StatelessWidget {
  const LoginSignButton({
    super.key, required this.title, required this.onPressed,
  });
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: RColors.primary ,
          padding: EdgeInsets.symmetric(vertical: 15.h , horizontal: 120.h),
        ),
        onPressed: onPressed,
        child: Text(title ,
          style: TextStyle(
              color: RColors.light ,
              fontWeight: FontWeight.bold
          ),
        ));
  }
}
class SecondButton extends StatelessWidget {
  const SecondButton({
    super.key, required this.title, required this.onPressed,
  });
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return SizedBox(
      width: 345.w,
      height: 55.h,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:RColors.white.withOpacity(0.7) ,
            side: BorderSide(
                width: 1.w ,
                color: RColors.primary
            ),
            padding: EdgeInsets.zero
          ),
          onPressed:onPressed,
          child: Text(title,
            style: TextStyle(
                color:  dark? RColors.light:RColors.primary ,
              fontWeight: FontWeight.bold
            ),
          )),
    );
  }
}
