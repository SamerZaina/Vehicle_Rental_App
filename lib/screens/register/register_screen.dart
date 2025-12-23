import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/login/login_screen.dart';
import 'package:vehicle_rental_app/agency/register/agency_register.dart';
import 'package:vehicle_rental_app/widgets/RAppbar.dart';
import 'package:vehicle_rental_app/widgets/divider_social_login.dart';
import '../../customer/data/controllers/customer_register/register_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/validators/validation.dart';
import '../../widgets/login_sign_button.dart';
import '../../widgets/login_text_fields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: dark
          ? RAppbarTheme.darkAppBarTheme()
          : RAppbarTheme.lightAppBarTheme(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0.h, 25.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page Title
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    width: 290.w,
                    height: 70.h,
                    child: Text(
                      RTexts.signupTitle,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: dark ? RColors.primary40 : RColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: RSizes.spaceBtwSections * 0.2.h),

                  Form(
                    key: controller.registerFormKey,
                    child: Column(
                      children: [
                        // Full Name
                        LoginTextFields(
                          keyboardType: TextInputType.text,
                          controller: controller.nameController,
                          hintText: RTexts.fullName,
                          icon: CupertinoIcons.person,
                          validator: (value) =>
                              RValidator.validateFullName(value),
                        ),

                        // Email
                        LoginTextFields(
                          controller: controller.emailController,
                          hintText: RTexts.loginEmail,
                          icon: CupertinoIcons.mail,
                          validator: (value) => RValidator.validateEmail(value),
                        ),

                        // Phone number
                        LoginTextFields(
                          controller: controller.phoneNumController,
                          hintText: RTexts.phoneNumber,
                          icon: CupertinoIcons.phone,
                          validator: (value) =>
                              RValidator.validatePhoneNumber(value),
                        ),

                        // Password
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

                        // Password Confirmation
                        Obx(
                              () => LoginTextFields(
                            controller:
                            controller.passwordConfirmationController,
                            hintText: 'تأكيد كلمة المرور',
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

                        // Driving License Picker
                        Obx(
                              () => Container(
                            margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 2),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: RColors.white,
                                border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: RColors.primary40),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: RColors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: controller.licenseName.value.isEmpty
                                    ? RTexts.drivingLicense
                                    : controller.licenseName.value,
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    controller.pickDrivingLicense();
                                  },
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                                suffixIcon:
                                const Icon(Icons.description_outlined),
                              ),
                            ),
                          ),
                        ),

                        // Buttons
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoginSignButton(
                                title: RTexts.signupBtn,
                                onPressed: () => controller.customerRegister(),
                              ),
                              SizedBox(height: RSizes.spaceBtwItems),
                              SecondButton(
                                title: RTexts.loginBtn,
                                onPressed: () =>
                                    Get.off(() => LoginScreen()),
                              ),
                              SizedBox(height: RSizes.spaceBtwItems),
                              SecondButton(
                                title: RTexts.agencySignupBtn,
                                onPressed: () =>
                                    Get.off(() => AgencyRegister()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: RSizes.defaultSpace.h),

                  // Social Login Divider
                  DividerSocialLogin(
                    onGooglePressed: () {},
                    onFacebookPressed: () {},
                  ),

                  SizedBox(height: RSizes.defaultSpace.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
