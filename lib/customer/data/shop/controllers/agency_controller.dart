import 'package:get/get.dart';
import 'package:vehicle_rental_app/customer/data/models/user/agency_model.dart';
import 'package:vehicle_rental_app/customer/data/shop/repositories/agency_repository.dart';

class AgencyController extends GetxController {
  static AgencyController get instance => Get.find();

  final repo = Get.put(AgencyRepository());

  final agencies = <AgencyModel>[].obs;
  final agencyVehicles = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAgencies();
  }

  Future<void> fetchAgencies() async {
    try {
      isLoading.value = true;
      error.value = '';
      agencies.value = await repo.fetchAllAgencies();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchVehicles({required int id}) async {
    try {
      isLoading.value = true;
      error.value = '';
      agencyVehicles.value = await repo.fetchAgencyVehicles(id);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }


}
