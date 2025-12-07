import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/login/login_screen.dart';
import 'package:vehicle_rental_app/widgets/RAppbar.dart';
import 'package:vehicle_rental_app/widgets/divider_social_login.dart';
import '../../core/api_constants.dart';
import '../../core/dio_client.dart';
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
  final fullNameController = TextEditingController();
  final phoneNumController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Scaffold(
      //  backgroundColor: dark ? RColors.blackF : RColors.primaryBackground,
        appBar: dark? RAppbarTheme.darkAppBarTheme(): RAppbarTheme.lightAppBarTheme(),
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
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: dark ? RColors.primary40 : RColors.primary,
                          ),
                        ),
                      ),
                      SizedBox(height: RSizes.spaceBtwSections*0.2.h),
                          Form(
                            key:registerFormKey ,
                            child: Column(
                              children: [
                                // Full name field
                                LoginTextFields(
                                  controller: fullNameController,
                                  hintText: RTexts.fullName,
                                  icon: CupertinoIcons.person,
                                  validator: (value) => RValidator.validateFullName(value),
                                ),
                                // Email Field
                                LoginTextFields(
                                  controller: emailController,
                                  hintText: RTexts.loginEmail,
                                  icon: CupertinoIcons.mail,
                                  validator: (value) => RValidator.validateEmail(value),
                                ),
                                //Phone number Field
                                LoginTextFields(
                                  controller: phoneNumController,
                                  hintText: RTexts.phoneNumber,
                                  icon: CupertinoIcons.phone,
                                  validator: (value) => RValidator.validatePhoneNumber(value),
                                ),
                                // Password Field
                                Obx(() => LoginTextFields(
                                    controller: passwordController,
                                    hintText: RTexts.loginPassword,
                                    icon: CupertinoIcons.lock,
                                    obscureText: hidePassword.value,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        hidePassword.value
                                            ? CupertinoIcons.eye_slash
                                            : CupertinoIcons.eye,
                                      ),
                                      onPressed: () => hidePassword.value = !hidePassword.value,
                                      color: RColors.grey,
                                    ),
                                    validator: (value) => RValidator.validateEmail(value),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Add Driving License
                          Container(
                            margin: EdgeInsets.fromLTRB(25.w, 0, 0, 12.h),
                            width: 400.w,
                            height: 60.h,
                            decoration:BoxDecoration(
                              color: dark ? RColors.primary70:RColors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: BoxBorder.all(
                                color: RColors.grey,
                                width: 0.8.w,
                              ) ,

                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,14,14,14),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.doc_person , color: RColors.primary40,) ,
                                  SizedBox(width: RSizes.spaceBtwItems.w,),
                                  Text(RTexts.drivingLicense,
                                    style: TextStyle(
                                        color: RColors.primary40,
                                        fontSize: 16.sp
                                    ),
                                  ) ,
                                  SizedBox(width: RSizes.spaceBtwSections*5.1.w,),
                                  IconButton(
                                      onPressed: (){},
                                      icon: Icon(CupertinoIcons.add_circled ,color: RColors.primary,size: 20.sp, ))

                                ],
                              ),
                            ),
                          ),
                      // Buttons
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoginSignButton(title: RTexts.signupBtn, onPressed: () {
                              if (!registerFormKey.currentState!.validate()) {
                                return;}
                            }),
                            SizedBox(height: RSizes.spaceBtwItems),
                            SecondButton(title: RTexts.loginBtn, onPressed: () async{
                              final response = await DioClient.dio.get(ApiConstants.users);
                              print(response.data);

                            }),
                            SizedBox(height: RSizes.spaceBtwItems),

                            SecondButton(title: RTexts.agencySignupBtn, onPressed: () async {
                              await createUserTest();
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: RSizes.defaultSpace.h),
                          DividerSocialLogin(
                              onGooglePressed: (){},
                              onFacebookPressed:(){}) ,
                          SizedBox(height: RSizes.defaultSpace.h),

                        ]
                      ) ),
                ) ))
                );
}
  Future<void> createUserTest() async {
    try {
      final response = await DioClient.dio.post(
        ApiConstants.users,
        data: {
          'name': 'Roaa ',
          'email': 'roaa@test.com',
          'phone': '0599000000',
          'password': '123456',
          'role': 'customer',
          'is_active': true,
          'is_approved': false,
          'profile_photo_path': 'some_path',
          'address': 'Gaza',
          'email_verified_at': null,
        },
      );

      print('Created user: ${response.data}');
    } catch (e) {
      print('Error while creating user: $e');
    }
  }

}

