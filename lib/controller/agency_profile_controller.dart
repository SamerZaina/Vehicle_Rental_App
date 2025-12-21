import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:vehicle_rental_app/api_service/api_service.dart';
import 'package:vehicle_rental_app/model/agency_profile_model.dart';
import 'package:vehicle_rental_app/model/agency_profile_response.dart';


class AgencyProfileModelController extends GetxController {


  /// Loading state
  final RxBool isLoading = false.obs;

  /// Error message
  final RxString errorMessage = ''.obs;

  /// Profile data (better than Rx<AgencyProfileModel?>)
  final Rxn<AgencyProfileModel> agencyProfile = Rxn<AgencyProfileModel>();

  // Endpoint (relative to baseUrl)
  final String profileUrl = '/agency/profile';
  ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchAgencyProfile();
  }

  /// ✅ Fetch agency profile
  Future<void> fetchAgencyProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiService.dio.get(profileUrl);

      final profileResponse =
      AgencyProfileResponse.fromJson(response.data);

      if (profileResponse.success) {
        agencyProfile.value = profileResponse.agency;

      } else {
        errorMessage.value = 'Failed to load agency profile';
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

  /// ✅ Update agency profile
  Future<void> updateAgencyProfile({
    required String agencyName,
    required String email,
    required String phone,
    String? agencyLicenseNumber,
    String? agencyLicenseFile
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiService.dio.put(
        profileUrl,
        data: {
          "agency_name": agencyName,
          "email": email,
          "phone": phone,
          "agencyLicenseNumber" : agencyLicenseNumber,
          "agencyLicenseFile" : agencyLicenseFile

        },
      );

      final profileResponse =
      AgencyProfileResponse.fromJson(response.data);

      if (profileResponse.success) {
        agencyProfile.value = profileResponse.agency;

        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        errorMessage.value = 'Failed to update agency profile';
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
