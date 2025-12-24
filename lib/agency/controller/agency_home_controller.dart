import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';

import 'package:vehicle_rental_app/model/vehicle_basic_details_modle.dart';

import '../../core/dio_client.dart';
import '../model/home_response_model.dart';
import '../model/vehicle_basic_details_modle.dart';

class HomeController extends GetxController {
  final isLoading = false.obs;

  final bestRatingCars = <VehicleBasicDetailsModle>[].obs;
  final recentAddedCars = <VehicleBasicDetailsModle>[].obs;
  final featuredCars = <VehicleBasicDetailsModle>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    try {
      isLoading.value = true;

      final Response response =
      await DioClient.dio.get('/agency/home'); // 🔁 adjust endpoint if needed

      final HomeVehiclesResponse data =
      HomeVehiclesResponse.fromJson(response.data);

      bestRatingCars.assignAll(data.bestRatingCars);
      recentAddedCars.assignAll(data.recentAddedCars);
      featuredCars.assignAll(data.featuredCars);
    } catch (e) {
      print('❌ Home API Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
