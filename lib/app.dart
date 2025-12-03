import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vehicle_rental_app/screens/bottom_navigation_items/details/booking_details.dart';
import 'package:vehicle_rental_app/screens/bottom_navigation_items/details/details_page.dart';
import 'package:vehicle_rental_app/screens/bottom_navigation_items/home_screen.dart';
import 'package:vehicle_rental_app/screens/bottom_navigation_items/profile/edit_profile_screen.dart';
import 'package:vehicle_rental_app/screens/on_boarding/onBoarding.dart';
import 'package:vehicle_rental_app/utils/theme/theme.dart';
import 'package:vehicle_rental_app/utils/theme/theme_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vehicle_rental_app/widgets/navigation_menu.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager.themeNotifier,
      builder: (context, themeMode, child) {
        print('الوضع الحالي: $themeMode');
        return ScreenUtilInit(
          designSize: Size(412, 917),
          minTextAdapt: true,
          splitScreenMode: true,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: GetMaterialApp(
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
              locale: const Locale("ar", "AE"),
              supportedLocales: [
                Locale("ar", "AE")],
              debugShowCheckedModeBanner: false,
              theme: RAppTheme.LightTheme,
              darkTheme: RAppTheme.DarkTheme,
              themeMode: themeMode,
              home: BookingDetails()
            ),
          ),
        );
      },
    );
  }
}


