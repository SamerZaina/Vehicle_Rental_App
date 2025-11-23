
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';

import '../utils/constants/sizes.dart';
import '../utils/helpers/helper_functions.dart';

class DividerSocialLogin extends StatelessWidget {
  const DividerSocialLogin({super.key , this.controller, required this.onGooglePressed, required this.onFacebookPressed});
  final dynamic controller;
  final VoidCallback onGooglePressed;
  final VoidCallback onFacebookPressed;

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(22, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Divider(color: dark? RColors.grey :RColors.darkGrey,thickness: 0.8,indent: 40,endIndent: 5,)),
              Text('أو' , style: Theme.of(context).textTheme.labelMedium,),
              Flexible(child: Divider(color: dark? RColors.grey :RColors.darkGrey,thickness: 0.8,indent: 5,endIndent: 40,))

            ],
          ),
        ),
        SizedBox(height: RSizes.defaultSpace,),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 340.w,
                height: 45.h,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:RColors.white.withOpacity(0.7) ,
                      side: BorderSide(
                          width: 1.2.w ,
                          color: RColors.primary70
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed:onGooglePressed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(RImages.googleIcon , width: 20.w, height: 20.h,),
                        SizedBox(width: RSizes.spaceBtwItems,),
                        Text('باستخدام جوجل',
                          style: TextStyle(
                              color:  dark? RColors.light:RColors.primary,
                              fontSize: 16.sp
                          ),
                        ),
                      ],
                    )),
              ) ,
              SizedBox(height: RSizes.spaceBtwItems,),
              Container(
                width: 340.w,
                height: 45.h,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: RColors.white.withOpacity(0.7) ,
                      side: BorderSide(
                          width: 1.2.w ,
                          color: RColors.primary70
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed:onFacebookPressed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(RImages.facebookIcon , width: 20.w, height: 20.h,),
                        SizedBox(width: RSizes.spaceBtwItems,),
                        Text('باستخدام فيسبوك',
                          style: TextStyle(
                              color:  dark? RColors.light:RColors.primary,
                              fontSize: 16.sp

                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
