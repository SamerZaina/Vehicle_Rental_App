import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/api_service/api_service.dart';

import '../../model/add_new_vehicle_modles/vehicle_types_model.dart';


class VehicleTypeController extends GetxController {
  final ApiService apiService = ApiService() ;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<String> carTypes = <String>[].obs;

  final String carTypesUrl = '/agency/cars/create'; // 🔁 adjust endpoint if needed

  @override
  void onInit() {
    super.onInit();
    fetchCarTypes();
  }

  /// ✅ Fetch car types
  Future<void> fetchCarTypes() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiService.dio.get(carTypesUrl);

      final carTypeResponse =
      VehicleTypeResponse.fromJson(response.data);

      if (carTypeResponse.success) {
        carTypes.value = carTypeResponse.carsType;
      } else {
        errorMessage.value = 'Failed to load car types';
      }
    } on DioException catch (e) {
      errorMessage.value =
          e.response?.data['message']?.toString() ?? 'Server error';
    } catch (e) {
      errorMessage.value = 'Unexpected error occurred';
    } finally {
      isLoading.value = false;
    }
  }
}
