
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../core/dio_client.dart';
import '../../model/add_new_vehicle_modles/fuel_type_model.dart';

class FuelTypeController extends GetxController {
  final Dio _dio = DioClient.dio;

  var isLoading = false.obs;
  final RxList<String> fuelTypes = <String>[].obs;

  Future<void> getFuelTypes() async {
    try {
      isLoading.value = true;

      final response = await _dio.get(
        '/agency/cars/getFuelType',
      );

      final model = FuelTypeModel.fromJson(response.data);

      if (model.success) {
        fuelTypes.assignAll(model.fuelTypes);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(), // show real error
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getFuelTypes();
  }
}


