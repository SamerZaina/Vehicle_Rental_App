import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../api_service/api_service.dart';
import 'package:vehicle_rental_app/model/vehicle_basic_details_modle.dart';

import '../model/vehicle_response.dart';


class AgencyCarsController extends GetxController {
  final ApiService apiService = ApiService();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<VehicleBasicDetailsModle> vehicles =
      <VehicleBasicDetailsModle>[].obs;

  final RxInt count = 0.obs;

  static const String carsUrl = '/agency/cars';

  @override
  void onInit() {
    super.onInit();
    fetchAgencyCars();
  }

  /// ✅ Fetch agency cars (GET)
  Future<void> fetchAgencyCars() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiService.dio.get(carsUrl);

      // Log the response for debugging
      print('Response data: ${response.data}');

      final allVehicleResponse =
      AllVehicleResponse.fromJson(response.data);

      if (allVehicleResponse.success) {
        vehicles.assignAll(allVehicleResponse.vehicles);
        count.value = allVehicleResponse.count;
      } else {
        errorMessage.value = 'Failed to load vehicles';
      }

    } on DioException catch (e) {
      print('Dio Error: $e');
      errorMessage.value =
          e.response?.data['message']?.toString() ??
              'Server error occurred: ${e.message}';

    } catch (e) {
      print('Unexpected Error: $e');
      errorMessage.value = 'Unexpected error occurred: $e';

    } finally {
      isLoading.value = false;
    }
  }
}