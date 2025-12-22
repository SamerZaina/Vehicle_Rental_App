import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vehicle_rental_app/utils/theme/theme_manager.dart';

import 'app.dart';
import 'app_start_controller.dart';
import 'core/api_constants.dart';
import 'core/dio_client.dart';
import 'api_service/api_service.dart'; // <- Make sure this import exists

void main() async {
  /// Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Dio
  DioClient.setupInterceptors();

  // Get token from storage
  //final token = GetStorage().read('token');

  //final token = await getTokenFromStorage();
  final token = "65|A1Wqzu0pnIM7RBRPgEKLXaOOeHl9nIvAAQlkuvPqae553877";

  /// Initialize ApiService (solution to late initialization error)
  /// so this line needed to insilize dio befor use controller .
  ApiService().init(token: token);

  // here we set the token from postman , only for test .
  //ApiService().setToken("24|OtOX9Vy12F6CpONg4xCyjplgGqEFgdbL0arwNZJQ519c1f57");

  await ThemeManager.init();

  /// GetX local storage
  await GetStorage.init();
  Get.put(AppStartController());

  runApp(const App());
}
