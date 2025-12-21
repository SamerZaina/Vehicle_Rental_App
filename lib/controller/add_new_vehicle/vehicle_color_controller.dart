
import 'package:get/get.dart';
import 'package:vehicle_rental_app/api_service/api_service.dart';
import '../../model/add_new_vehicle_modles/vehicle_color_model.dart';

class VehicleColorController extends GetxController {
  // here the dio from api service class
  final ApiService _apiService = ApiService();

  final RxBool isLoading = false.obs;
  final RxList<String> colors = <String>[].obs;

  static const String colorsUrl = '/agency/cars/getColor';

  @override
  void onInit() {
    super.onInit();
    fetchVehicleColors();
  }

  Future<void> fetchVehicleColors() async {
    try {
      isLoading.value = true;

      final response = await _apiService.dio.get(colorsUrl);

      final model = VehicleColorResponse.fromJson(response.data);

      if (model.success) {
        colors.assignAll(model.colors);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
