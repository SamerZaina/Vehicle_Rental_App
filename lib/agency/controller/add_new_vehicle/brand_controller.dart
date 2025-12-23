import 'package:get/get.dart';

import '../../api_service/api_service.dart';
import '../../model/add_new_vehicle_modles/brand_model.dart';


class BrandController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<BrandModel> brands = <BrandModel>[].obs;

  /// Optional: cache brands by car type to avoid multiple requests
  final Map<String, List<BrandModel>> _cache = {};

  /// Fetch brands dynamically based on selected car type
  Future<void> fetchBrands(String carType) async {
    try {
      isLoading.value = true;

      // If cached, use cache
      if (_cache.containsKey(carType)) {
        brands.assignAll(_cache[carType]!);
        return;
      }

      // API call
      final response = await ApiService().dio.get('/agency/cars/get/$carType');

      final model = BrandResponseModel.fromJson(response.data);

      if (model.success) {
        brands.assignAll(model.brands);
        // Cache for later use
        _cache[carType] = model.brands;
      } else {
        brands.clear();
      }
    } catch (e) {
      brands.clear();
      Get.snackbar(
        'Error',
        'Failed to load brands',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Optional: reset brand list when car type changes
  void clearBrands() {
    brands.clear();
  }
}
