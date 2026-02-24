import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vehicle_rental_app/utils/theme/theme_manager.dart';


import 'app.dart';
import 'app_start_controller.dart';
import 'core/api_constants.dart';
import 'core/dio_client.dart';

void main() async {
  /// Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Dio
  DioClient.setupInterceptors();

  await ThemeManager.init();

  /// GetX local storage
  await GetStorage.init();
  Get.put(AppStartController());

  runApp(const App());
}
