import 'package:get/get.dart';
import '../../api_service/api_service.dart';
import '../../model/add_new_vehicle_modles/brand_modle_modle.dart';


class VehicleModelController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<VehicleModel> models = <VehicleModel>[].obs;

  /// Optional: cache models per vehicleType + brandId combination
  final Map<String, List<VehicleModel>> _cache = {};

  /// Fetch models based on vehicle type and brand ID
  Future<void> fetchModels(String vehicleType, int brandId) async {
    try {
      isLoading.value = true;

      final cacheKey = '$vehicleType-$brandId';

      // Use cache if available
      if (_cache.containsKey(cacheKey)) {
        models.assignAll(_cache[cacheKey]!);
        return;
      }

      // API call
      final response = await ApiService().dio.get('/agency/cars/get/$vehicleType/$brandId');

      final modelResponse = VehicleModelResponse.fromJson(response.data);

      if (modelResponse.success) {
        models.assignAll(modelResponse.models);
        _cache[cacheKey] = modelResponse.models; // Cache for later
      } else {
        models.clear();
      }
    } catch (e) {
      models.clear();
      Get.snackbar(
        'Error',
        'Failed to load models',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear models when brand or vehicle type changes
  void clearModels() {
    models.clear();
  }
}
