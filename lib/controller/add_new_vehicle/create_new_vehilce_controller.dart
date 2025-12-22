import 'dart:core';
import 'dart:core' as dio;

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api_service/api_service.dart';
import '../../model/add_new_vehicle_modles/create_new_vehicle_model.dart';

class AddNewVehicleController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxBool isLoading = false.obs;

  /// ✅ Add new vehicle (POST)
  /// Returns true if success (200 / 201), false otherwise
  Future<bool> addNewVehicle(CreateVehicleModel vehicle) async {
    try {
      isLoading.value = true;

      /// 🔹 Debug
      print('📱 ===== START Add New Vehicle =====');
      print('📱 Vehicle modelId: ${vehicle.modelId}');
      print('📱 Vehicle transmission: ${vehicle.transmission}');
      print('📱 Vehicle color: ${vehicle.color}');
      print('📱 Vehicle fuelType: ${vehicle.fuelType}');
      print('📱 Vehicle status: ${vehicle.status}');
      print('📱 Vehicle registration: ${vehicle.registrationNumber}');
      print('📱 Vehicle seats: ${vehicle.seats}');
      print('📱 Vehicle doors: ${vehicle.doors}');
      print('📱 Vehicle price: ${vehicle.pricePerHour}');
      print('📱 Vehicle description: ${vehicle.description}');
      print('📱 Images count: ${vehicle.images?.length}');
      if (vehicle.images != null) {
        for (int i = 0; i < vehicle.images!.length; i++) {
          print('📱 Image $i path: ${vehicle.images![i].path}');
        }
      }

      /// 🔹 Build FormData
      final formData = dio.FormData();

      /// Add normal fields
      final jsonData = vehicle.toJson();
      print('📱 JSON data to send: $jsonData');

      jsonData.forEach((key, value) {
        if (value != null) {
          formData.fields.add(
            dio.MapEntry(key, value.toString()),
          );
          print('📱 Added field: $key = $value');
        }
      });

      /// Add images as images[]
      if (vehicle.images != null && vehicle.images!.isNotEmpty) {
        for (int i = 0; i < vehicle.images!.length; i++) {
          final image = vehicle.images![i];
          final fileName = image.path.split('/').last;
          final fileSize = await image.length();

          print('📱 Adding image $i: $fileName (${fileSize} bytes)');

          // FIXED: Correct way to add MultipartFile to FormData
          formData.files.add(
            dio.MapEntry(
              'images[]', // Use 'images[]' for array format
              await dio.MultipartFile.fromFile(
                image.path,
                filename: fileName,
              ),
            ),
          );
        }
      } else {
        print('📱 No images to upload');
      }

      // Log form data structure
      print('📱 FormData fields: ${formData.fields.length}');
      print('📱 FormData files: ${formData.files.length}');

      /// 🔹 Send POST request
      print('📱 Sending POST request to /agency/cars/store');
      final response = await _apiService.dio.post(
        '/agency/cars/store',
        data: formData,
        options: dio.Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print('📱 ✅ Request completed');
      print('📱 Status code: ${response.statusCode}');
      print('📱 Response headers: ${response.headers}');
      print('📱 Response data: ${response.data}');

      /// ✅ Success - Check response structure
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          final data = response.data as Map<String, dynamic>;

          print('📱 Response keys: ${data.keys}');

          // Check for success flag
          if (data.containsKey('success')) {
            final success = data['success'] == true;
            if (success) {
              print('📱 ✅ Vehicle added successfully!');

              // Show success snackbar
              Get.snackbar(
                'تمت الإضافة بنجاح',
                'تم إضافة المركبة بنجاح',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: Duration(seconds: 3),
                icon: Icon(Icons.check_circle, color: Colors.white),
                shouldIconPulse: true,
              );

              // Optionally, you can parse and return the created vehicle data
              if (data.containsKey('car') || data.containsKey('data')) {
                print('📱 Vehicle data returned from API');
              }

              return true;
            } else {
              // API returned success: false
              final errorMsg = data['message'] ?? 'فشل إضافة المركبة';
              print('📱 ❌ API returned success: false - $errorMsg');

              Get.snackbar(
                'خطأ',
                errorMsg.toString(),
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.orange,
                colorText: Colors.white,
                duration: Duration(seconds: 3),
              );

              return false;
            }
          } else {
            // No success flag in response, assume success based on status code
            print('📱 ⚠️ No success flag in response, assuming success based on status code');

            Get.snackbar(
              'تمت الإضافة',
              'تم إرسال طلب إضافة المركبة',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: Duration(seconds: 3),
            );

            return true;
          }
        } else {
          // Response is not a Map
          print('📱 ⚠️ Response is not a Map, assuming success based on status code');
          return true;
        }
      } else {
        // Non-200/201 status code
        print('📱 ❌ Unexpected status code: ${response.statusCode}');

        Get.snackbar(
          'خطأ',
          'استجابة غير متوقعة من الخادم (${response.statusCode})',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );

        return false;
      }

    } on dio.DioException catch (e) {
      print('📱 ❌ ===== DIO EXCEPTION =====');
      print('📱 Error type: ${e.type}');
      print('📱 Error message: ${e.message}');
      print('📱 Error response: ${e.response}');
      print('📱 Status code: ${e.response?.statusCode}');
      print('📱 Response data: ${e.response?.data}');
      print('📱 Request options: ${e.requestOptions}');

      String errorMessage = 'فشل في إضافة المركبة';
      String errorDetails = '';

      // Extract error message from response
      if (e.response?.data != null) {
        if (e.response!.data is Map<String, dynamic>) {
          final errorData = e.response!.data as Map<String, dynamic>;
          errorDetails = errorData['message']?.toString() ??
              errorData['error']?.toString() ??
              e.message ?? 'خطأ غير معروف';
        } else if (e.response!.data is String) {
          errorDetails = e.response!.data;
        } else {
          errorDetails = e.message ?? 'خطأ في الاتصال';
        }
      } else {
        errorDetails = e.message ?? 'خطأ في الاتصال بالخادم';
      }

      // Handle specific error types
      if (e.type == dio.DioExceptionType.connectionTimeout ||
          e.type == dio.DioExceptionType.receiveTimeout ||
          e.type == dio.DioExceptionType.sendTimeout) {
        errorMessage = 'انتهت مهلة الاتصال';
      } else if (e.type == dio.DioExceptionType.connectionError) {
        errorMessage = 'خطأ في الاتصال بالخادم';
      } else if (e.response?.statusCode == 422) {
        // Validation error
        errorMessage = 'خطأ في البيانات المدخلة';
        if (e.response?.data is Map<String, dynamic>) {
          final errors = e.response!.data['errors'];
          if (errors is Map<String, dynamic>) {
            errorDetails = errors.values.first?.first?.toString() ?? 'بيانات غير صحيحة';
          }
        }
      } else if (e.response?.statusCode == 401) {
        errorMessage = 'غير مصرح بالوصول';
        errorDetails = 'يرجى تسجيل الدخول مرة أخرى';
      } else if (e.response?.statusCode == 403) {
        errorMessage = 'غير مسموح بالوصول';
        errorDetails = 'ليس لديك صلاحية لإضافة مركبة';
      } else if (e.response?.statusCode == 404) {
        errorMessage = 'الصفحة غير موجودة';
        errorDetails = 'مسار API غير صحيح';
      } else if (e.response?.statusCode == 500) {
        errorMessage = 'خطأ في الخادم';
        errorDetails = 'خطأ داخلي في الخادم';
      }

      print('📱 Error to display: $errorMessage - $errorDetails');

      // Show error snackbar
      Get.snackbar(
        errorMessage,
        errorDetails,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        icon: Icon(Icons.error_outline, color: Colors.white),
        shouldIconPulse: true,
        margin: EdgeInsets.all(10),
      );

      return false;

    } catch (e, stackTrace) {
      print('📱 ❌ ===== UNEXPECTED ERROR =====');
      print('📱 Error: $e');
      print('📱 StackTrace: $stackTrace');

      Get.snackbar(
        'خطأ غير متوقع',
        'حدث خطأ غير متوقع: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );

      return false;

    } finally {
      print('📱 ===== END Add New Vehicle =====');
      isLoading.value = false;
    }
  }
}