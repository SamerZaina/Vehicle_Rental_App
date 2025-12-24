
import 'dart:core';
import 'dart:core' as dio;

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/core/dio_client.dart';
import 'package:vehicle_rental_app/model/vehicle_basic_details_modle.dart';

import '../../model/add_new_vehicle_modles/create_new_vehicle_model.dart';
import '../../model/vehicle_basic_details_modle.dart';

class AddNewVehicleController extends GetxController {
  final Dio _dioClient = DioClient.dio;
  final RxBool isLoading = false.obs;

  /// ✅ Add new vehicle (POST)
  /// Returns VehicleBasicDetailsModle if success, null otherwise
  Future<VehicleBasicDetailsModle?> addNewVehicle(CreateVehicleModel vehicle) async {
    try {
      isLoading.value = true;

      /// 🔹 Debug
      print('📱 ===== START Add New Vehicle =====');
      print('📱 Vehicle modelId: ${vehicle.modelId}');
      print('📱 Vehicle registration: ${vehicle.registrationNumber}');
      print('📱 Images count: ${vehicle.images?.length}');

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
        }
      });

      /// Add images
      if (vehicle.images != null && vehicle.images!.isNotEmpty) {
        for (int i = 0; i < vehicle.images!.length; i++) {
          final image = vehicle.images![i];
          final fileName = image.path.split('/').last;

          formData.files.add(
            dio.MapEntry(
              'images[]',
              await dio.MultipartFile.fromFile(
                image.path,
                filename: fileName,
              ),
            ),
          );
        }
      }

      /// 🔹 Send POST request
      print('📱 Sending POST request to /agency/cars/store');
      final response = await _dioClient.post(
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

      /// ✅ Success - Parse response
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          final data = response.data as Map<String, dynamic>;

          // Check for success flag
          final bool success = data['success'] as bool? ?? true;

          if (success) {
            print('📱 ✅ Vehicle added successfully!');

            // ✅ FIX: Try to parse and return the created vehicle
            VehicleBasicDetailsModle? createdVehicle;

            if (data.containsKey('car')) {
              // Try to parse from 'car' key
              try {
                createdVehicle = VehicleBasicDetailsModle.fromJson(data['car'] as Map<String, dynamic>);
                print('📱 ✅ Parsed vehicle from "car" key');
              } catch (e) {
                print('📱 ❌ Error parsing vehicle from "car" key: $e');
              }
            } else if (data.containsKey('data')) {
              // Try to parse from 'data' key
              try {
                createdVehicle = VehicleBasicDetailsModle.fromJson(data['data'] as Map<String, dynamic>);
                print('📱 ✅ Parsed vehicle from "data" key');
              } catch (e) {
                print('📱 ❌ Error parsing vehicle from "data" key: $e');
              }
            } else if (data.containsKey('vehicle')) {
              // Try to parse from 'vehicle' key
              try {
                createdVehicle = VehicleBasicDetailsModle.fromJson(data['vehicle'] as Map<String, dynamic>);
                print('📱 ✅ Parsed vehicle from "vehicle" key');
              } catch (e) {
                print('📱 ❌ Error parsing vehicle from "vehicle" key: $e');
              }
            }

            // Show success message
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

            return createdVehicle; // Return the parsed vehicle

          } else {
            // API returned success: false
            final errorMsg = data['message'] ?? 'فشل إضافة المركبة';

            Get.snackbar(
              'خطأ',
              errorMsg.toString(),
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.orange,
              colorText: Colors.white,
              duration: Duration(seconds: 3),
            );

            return null;
          }
        } else {
          // Response is not a Map but status is success
          print('📱 ⚠️ Response is not a Map, but status is success');

          Get.snackbar(
            'تمت الإضافة',
            'تم إرسال طلب إضافة المركبة',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
          );

          return null;
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

        return null;
      }

    } on dio.DioException catch (e) {
      print('📱 ❌ DIO EXCEPTION: ${e.message}');

      String errorMessage = 'فشل في إضافة المركبة';
      String errorDetails = e.message ?? 'خطأ في الاتصال';

      // Extract error message from response
      if (e.response?.data != null) {
        if (e.response!.data is Map<String, dynamic>) {
          final errorData = e.response!.data as Map<String, dynamic>;
          errorDetails = errorData['message']?.toString() ??
              errorData['error']?.toString() ??
              errorDetails;
        }
      }

      // Show error snackbar
      Get.snackbar(
        errorMessage,
        errorDetails,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );

      return null;

    } catch (e, stackTrace) {
      print('📱 ❌ UNEXPECTED ERROR: $e');

      Get.snackbar(
        'خطأ غير متوقع',
        'حدث خطأ غير متوقع',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );

      return null;

    } finally {
      print('📱 ===== END Add New Vehicle =====');
      isLoading.value = false;
    }
  }
}

