import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';

import '../../utils/constants/image_strings.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/device/device_utility.dart';
import '../../utils/helpers/helper_functions.dart';
import 'onboarding_controller.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller:  controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const[
              onBoadrdingPage(
                  image: RImages.onBoardingImage1,
                  tittle: RTexts.onBoardingWelcome,
                  subTittle: ''),
              onBoadrdingPage(
                  image: RImages.onBoardingImage2,
                  tittle: RTexts.onBoardingTitle2,
                  subTittle: RTexts.onBoardingSubTitle),
            ],
          ),
          onBoardingIndicator(),
          StartButton(),

        ]

      ),
    );

  }
}
class onBoardingIndicator extends StatelessWidget {
  const onBoardingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    return Positioned(
        bottom: RDeviceUtils.getBottomNavigationBarHeight()+80.h,
        right: RSizes.defaultSpace*7,
        child: SmoothPageIndicator(controller: controller.pageController,
            onDotClicked: controller.dotClick,
            count: 2 ,
            effect: ExpandingDotsEffect(activeDotColor: RColors.light,dotHeight: 6 ,
            )) );
  }
}

class onBoadrdingPage extends StatelessWidget {
  const onBoadrdingPage({
    super.key,
    required this.image,
    required this.tittle,
    required this.subTittle,
  });
  final String image, tittle, subTittle;
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
             image,
              // width: double.infinity,
              //height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    RColors.primary.withOpacity(0.9),
                    RColors.primary.withOpacity(0.4),
                    RColors.primary.withOpacity(0.1),
                  ],
                  stops: const [0.2, 0.4, 2.0],
                ),
              ),
            ),
          ),

          Positioned(
            top: 130.h,
            right: 40.w,
            child: Text(
             tittle,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: RColors.primaryBackground,
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 150.h,
            right: 20.w,
            child: Text(
             subTittle,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: RColors.primaryBackground,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],

    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50.h,
      right: 30.w,
      child: Container(
        height: 62.h,
        width: 350.w,
        child: ElevatedButton(
          onPressed: ()=> OnBoardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(
            shadowColor: RColors.primaryBackground,
            elevation: 0.3,
            backgroundColor: RColors.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            RTexts.onBoardingButton,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
