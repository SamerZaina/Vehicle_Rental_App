import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/data/controllers/login/login_controller.dart';
import 'package:vehicle_rental_app/screens/agency_bottom_navigation_item/bottom_navigation.dart';
import 'package:vehicle_rental_app/screens/bottom_navigation_items/home_screen.dart';
import 'package:vehicle_rental_app/screens/bottom_navigation_items/profile/profile_screen.dart';
import 'package:vehicle_rental_app/screens/login/forget_password.dart';
import 'package:vehicle_rental_app/screens/register/register_screen.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/validators/validation.dart';
import 'package:vehicle_rental_app/widgets/divider_social_login.dart';
import 'package:vehicle_rental_app/widgets/login_text_fields.dart';
import 'package:vehicle_rental_app/widgets/navigation_menu.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../widgets/RAppbar.dart';
import '../../widgets/login_sign_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: dark
          ? RAppbarTheme.darkAppBarTheme()
          : RAppbarTheme.lightAppBarTheme(),

      // backgroundColor: dark ? RColors.blackF : RColors.primaryBackground,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0.h, 25.w, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page Title
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 5),
                    width: 290.w,
                    height: 80.h,
                    child: Text(
                      RTexts.loginWelcome,
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: dark ? RColors.primary40 : RColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: RSizes.spaceBtwSections.h * 1.6),
                  Form(
                    key: controller.loginFormKey,
                    child: Column(
                      children: [
                        // Email Field
                        LoginTextFields(
                          controller: controller.emailController,
                          hintText: RTexts.loginEmail,
                          icon: CupertinoIcons.mail,
                          validator: (value) => RValidator.validateEmail(value),
                        ),
                        // Password Field
                        Obx(
                              () => LoginTextFields(
                            controller: controller.passwordController,
                            hintText: RTexts.loginPassword,
                            icon: CupertinoIcons.lock,
                            obscureText: controller.hidePassword.value,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.hidePassword.value
                                    ? CupertinoIcons.eye_slash
                                    : CupertinoIcons.eye,
                              ),
                              onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                              color: RColors.grey,
                            ),
                            validator: (value) =>
                                RValidator.validatePassword(value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Remember me and forgot password?
                  SizedBox(
                    width: double.infinity.w,
                    child: Row(
                      children: [
                        Obx(
                              () => Checkbox(
                            checkColor: RColors.light,
                            activeColor: RColors.primary40,
                            side: BorderSide(
                              width: 1.w,
                              color: RColors.primary40,
                            ),
                            value: controller.rememberMe.value,
                            onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value,
                          ),
                        ),
                        Text(
                          RTexts.rememberMe,
                          style: TextStyle(
                            color: dark ? RColors.primary40 : RColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(width: RSizes.spaceBtwSections * 4.w),
                        GestureDetector(
                          onTap: () {
                            Get.to(ForgetPassword());
                          },
                          child: Text(
                            RTexts.forgotPassword,
                            style: TextStyle(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w500,
                              color: dark ? RColors.primary40 : RColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Buttons
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoginSignButton(
                          title: RTexts.loginBtn,
                          onPressed: () => controller.loginUser(),
                        ),
                        SizedBox(height: RSizes.spaceBtwItems),
                        SecondButton(
                          title: RTexts.signupBtn,
                          onPressed: () {
                            Get.off(() => RegisterScreen());
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: RSizes.defaultSpace.h),
                  DividerSocialLogin(
                    onGooglePressed: () {},
                    onFacebookPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
