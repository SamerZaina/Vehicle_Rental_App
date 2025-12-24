
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/core/dio_client.dart';
import '../../model/add_new_vehicle_modles/transmission_type_model.dart';


class TransmissionController extends GetxController {
  final Dio _dio = DioClient.dio;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<String> transmissions = <String>[].obs;

  final String transmissionUrl = '/agency/cars/getTransmission';

  @override
  void onInit() {
    super.onInit();
    fetchTransmissions();
  }

  /// ✅ Fetch transmission types
  Future<void> fetchTransmissions() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _dio.get(transmissionUrl);

      final transmissionResponse =
      TransmissionResponse.fromJson(response.data);

      if (transmissionResponse.success) {
        transmissions.value = transmissionResponse.transmission;
      } else {
        errorMessage.value = 'Failed to load transmission types';
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
