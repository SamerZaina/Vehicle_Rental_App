import 'package:dio/dio.dart' as dio;
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
      print('📱 Vehicle data: ${vehicle.toJson()}');
      print('📱 Images count: ${vehicle.images?.length}');

      /// 🔹 Build FormData
      final formData = dio.FormData();

      /// Add normal fields
      vehicle.toJson().forEach((key, value) {
        if (value != null) {
          formData.fields.add(
            MapEntry(key, value.toString()),
          );
        }
      });

      /// Add images as images[]
      for (final image in vehicle.images ?? []) {
        formData.files.add(
          MapEntry(
            'images[]',
            await dio.MultipartFile.fromFile(
              image.path,
              filename: image.path.split('/').last,
            ),
          ),
        );
      }

      /// 🔹 Send POST request
      final response = await _apiService.dio.post(
        '/agency/cars/store',
        data: formData,
      );

      print('📱 Status code: ${response.statusCode}');
      print('📱 Response data: ${response.data}');

      /// ✅ Success
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      return false;

    } on dio.DioException catch (e) {
      print('❌ Dio error: ${e.message}');
      print('❌ Status: ${e.response?.statusCode}');
      print('❌ Data: ${e.response?.data}');
      return false;

    } catch (e, stackTrace) {
      print('❌ Error: $e');
      print('❌ StackTrace: $stackTrace');
      return false;

    } finally {
      isLoading.value = false;
    }
  }
}
