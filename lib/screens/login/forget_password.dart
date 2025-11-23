import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vehicle_rental_app/screens/login/login_screen.dart';
import 'package:vehicle_rental_app/screens/register/register_screen.dart';
import 'package:vehicle_rental_app/utils/constants/text_strings.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/validators/validation.dart';
import '../../widgets/RAppbar.dart';

class ForgetPassword extends StatelessWidget {
   ForgetPassword({super.key});
   final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: dark? RAppbarTheme.darkAppBarTheme(): RAppbarTheme.lightAppBarTheme(),
      body: Padding(padding: const EdgeInsets.all(RSizes.defaultSpace,),
        child:Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(RTexts.forgotPasswordTitle, style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: dark ?RColors.primary40 : RColors.primary ,
                  fontWeight: FontWeight.w600
              ),),
              const SizedBox(height: RSizes.spaceBtwItems,),
              Text(RTexts.forgotPasswordPageSubtitle , style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14
              ),),
              const SizedBox(height: RSizes.spaceBtwSections*2,),

              TextFormField(
                  controller: emailController,
                  validator: (value)=>RValidator.validateEmail(value),
                  decoration:  InputDecoration(
                      enabledBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: RColors.grey ,
                          )
                      ) ,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),

                          borderSide: BorderSide(
                            color: RColors.primary ,
                          )
                      ),
                      labelText: RTexts.loginEmail ,
                      prefixIcon: Icon(CupertinoIcons.arrowtriangle_left_fill)
                  ),
                ),

              const SizedBox(height: RSizes.spaceBtwSections,),
              SizedBox(
                height: 60.h,
                width: double.infinity.w,
                child: ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RColors.buttonPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    elevation: 0,
                  ),
                  child:  Text(
                    'ارسال',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600 ,
                      color: RColors.primaryBackground,
                    ),
                  ),
                ),
              ),
              SizedBox(height: RSizes.spaceBtwItems.h,),
              Center(
                child: TextButton(onPressed: (){
                  Get.to(LoginScreen());
                },
                    child: Text('الرجوع لتسجيل الدخول' ,
                    style:Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: dark? RColors.grey :RColors.darkerGrey,
                      fontWeight: FontWeight.bold
                    ),
                    )
                ),
              ) ,
              SizedBox(height: RSizes.spaceBtwSections*9.h),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('انشاء' ,
                    style: Theme.of(context).textTheme.titleSmall,),
                    TextButton(onPressed: (){
                      Get.to(RegisterScreen());
                    },
                        child: Text('حساب جديد' ,
                          style:Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: RColors.primary40,
                              fontWeight: FontWeight.w900
                          ),
                        )
                    ),
                  ],

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RAppbar extends StatelessWidget {
  const RAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return AppBar(
      backgroundColor: dark ?RColors.blackF :RColors.primaryBackground,
      scrolledUnderElevation: 0,
      leading:  Container(
        margin: EdgeInsets.fromLTRB(0, 15, 15, 0),
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: RColors.primary40,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Icon(
          CupertinoIcons.car_detailed,
          color: dark ? RColors.dark : RColors.primaryBackground,
          size: 30.sp,
        ),
      ),
    );
  }
}