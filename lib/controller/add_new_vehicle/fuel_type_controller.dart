import 'package:get/get.dart';
import '../../api_service/api_service.dart';
import '../../model/add_new_vehicle_modles/fuel_type_model.dart';

class FuelTypeController extends GetxController {
  final apiService = ApiService();

  var isLoading = false.obs;
  final RxList<String> fuelTypes = <String>[].obs;

  Future<void> getFuelTypes() async {
    try {
      isLoading.value = true;

      final response = await apiService.dio.get(
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
