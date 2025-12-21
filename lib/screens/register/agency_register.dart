import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/data/controllers/customer_register/register_controller.dart';
import 'package:vehicle_rental_app/screens/register/register_screen.dart';
import 'package:vehicle_rental_app/widgets/RAppbar.dart';
import 'package:vehicle_rental_app/widgets/divider_social_login.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/validators/validation.dart';
import '../../widgets/login_sign_button.dart';
import '../../widgets/login_text_fields.dart';

class AgencyRegister extends StatefulWidget {
  const AgencyRegister({super.key});

  @override
  State<AgencyRegister> createState() => _AgencyRegisterState();
}

class _AgencyRegisterState extends State<AgencyRegister> {

  final controller = Get.put(AgencyRegisterController());

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: dark ? RAppbarTheme.darkAppBarTheme() : RAppbarTheme
            .lightAppBarTheme(),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            // app icon
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0.h, 25.w, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                // Page Tittle
                Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                width: 290.w,
                height: 70.h,
                child: Text(
                  RTexts.signupTitle,
                  style: Theme
                      .of(context)
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
                  // Full name field
                  LoginTextFields(
                  controller: controller.nameController,
                  hintText: "اسم الوكالة",
                  icon: CupertinoIcons.person,
                  validator: (value) => RValidator.validateFullName(value),
                ),
                // Email Field
                LoginTextFields(
                  controller: controller.emailController,
                  hintText: RTexts.loginEmail,
                  icon: CupertinoIcons.mail,
                  validator: (value) => RValidator.validateEmail(value),
                ),
                //Phone number Field
                LoginTextFields(
                  controller: controller.phoneNumController,
                  hintText: RTexts.phoneNumber,
                  icon: CupertinoIcons.phone,
                  validator: (value) => RValidator.validatePhoneNumber(value),
                ),
                //address Field
                LoginTextFields(
                    controller: controller.addressController,
                    hintText: 'عنوان الوكالة',
                    icon: CupertinoIcons.location,
                    validator: (value) => RValidator.validateEmptyText(value,'عنوان الوكالة'),
              ),
              //commercial register Field
              LoginTextFields(
                  controller: controller.commercialRegisterController,
                  hintText: 'رخصة الوكالة',
                  icon: CupertinoIcons.rectangle_paperclip,
                  validator: (value) => RValidator.validateEmptyText(value,'رخصة الوكالة'),
            ),
            // Password Field
            Obx(() =>
                LoginTextFields(
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
                    onPressed: () =>
                    controller.hidePassword.value =
                    !controller.hidePassword.value,
                    color: RColors.grey,
                  ),
                  validator: (value) => RValidator.validatePassword(value),
                ),
            ),
            Obx(() =>
                LoginTextFields(
                  controller: controller.passwordConfirmationController,
                  hintText: 'تأكيد كلمة المرور',
                  icon: CupertinoIcons.lock,
                  obscureText: controller.hidePassword.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.hidePassword.value
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye,
                    ),
                    onPressed: () =>
                    controller.hidePassword.value =
                    !controller.hidePassword.value,
                    color: RColors.grey,
                  ),
                  validator: (value) => RValidator.validatePassword(value),
                ),
            ),

            ],
          ),

        ),
        // Add License
                      Obx(() {
                        return Container(
                          margin: EdgeInsets.fromLTRB(5, 0,0, 0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18,
                                vertical: 2),
                            child: Center(
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: RColors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: RColors.primary40,

                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: RColors.grey,

                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: controller.licenseName.value.isEmpty
                                      ? 'ملف رخصة الوكالة'
                                      : controller.licenseName.value,
                                  prefixIcon: IconButton(
                                    onPressed: () {
                                      controller.pickLicense();
                                    },
                                    icon: const Icon(Icons.add_circle_outline),
                                  ),
                                  suffixIcon: const Icon(Icons.description_outlined),
                                ),

                              ),
                            ),
                          ),
                        );
                      }),
        // Buttons
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginSignButton(title: RTexts.signupBtn,
                  onPressed: () => controller.agencyRegister()
              ),
              SizedBox(height: RSizes.spaceBtwItems),
              SecondButton(title: RTexts.loginBtn, onPressed: () {},),
              SizedBox(height: RSizes.spaceBtwItems),

              SecondButton(title: "تسجيل جديد كمستخدم", onPressed: () async {
                await Get.to(RegisterScreen());
              }),
            ],
          ),
        ),
        SizedBox(height: RSizes.defaultSpace.h),
        DividerSocialLogin(
            onGooglePressed: () {},
            onFacebookPressed: () {}),
        SizedBox(height: RSizes.defaultSpace.h),

        ]
    ) ),
    )
    )
    )
    );
  }


}