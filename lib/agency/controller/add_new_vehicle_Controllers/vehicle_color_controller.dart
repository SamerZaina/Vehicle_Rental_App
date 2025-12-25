
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/core/dio_client.dart';
import '../../model/add_new_vehicle_modles/vehicle_color_model.dart';

class VehicleColorController extends GetxController {
  // here the dio from api service class
  final Dio _dio = DioClient.dio ;

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

      final response = await _dio.get(colorsUrl);

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
