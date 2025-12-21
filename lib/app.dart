import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vehicle_rental_app/bindings/general_bindings.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
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
              initialBinding: GeneralBindings(),
              home: const Scaffold(
                backgroundColor: RColors.primary,
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


