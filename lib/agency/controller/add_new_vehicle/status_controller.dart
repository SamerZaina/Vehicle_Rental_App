import 'package:get/get.dart';
import '../../api_service/api_service.dart';
import '../../model/add_new_vehicle_modles/status_model.dart';

class VehicleStatusController extends GetxController {
  final apiService = ApiService();

  var isLoading = false.obs;
  final RxList<String> statusList = <String>[].obs;

  Future<void> getVehicleStatus() async {
    try {
      isLoading.value = true;

      final response = await apiService.dio.get(
        '/agency/cars/getStatus',
      );

      final model = VehicleStatusModel.fromJson(response.data);

      if (model.success) {
        statusList.assignAll(model.status);
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
    getVehicleStatus(); // ✅ auto-fetch
  }
}
