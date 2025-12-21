import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '../api_service/api_service.dart';
import 'package:vehicle_rental_app/model/vehicle_basic_details_modle.dart';

// Make sure this file exists and has the correct structure
import '../model/vehicle_response.dart'; // This should be AllVehicleResponse

class AgencyCarsController extends GetxController {
  final ApiService apiService = ApiService();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<VehicleBasicDetailsModle> vehicles =
      <VehicleBasicDetailsModle>[].obs;

  final RxInt count = 0.obs;

  static const String carsUrl = '/agency/cars';

  @override
  void onInit() {
    super.onInit();
    fetchAgencyCars();
  }

  /// ✅ Fetch agency cars (GET)
  Future<void> fetchAgencyCars() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await apiService.dio.get(carsUrl);

      // Log the response for debugging
      print('=== Fetch Agency Cars Response ===');
      print('Response status: ${response.statusCode}');
      print('Response data type: ${response.data.runtimeType}');

      Map<String, dynamic> responseData;

      // Handle both Map and String responses
      if (response.data is Map<String, dynamic>) {
        responseData = response.data;
      } else if (response.data is String) {
        try {
          responseData = jsonDecode(response.data) as Map<String, dynamic>;
        } catch (e) {
          throw FormatException('Failed to decode JSON string: $e');
        }
      } else {
        throw FormatException('Unexpected response type: ${response.data.runtimeType}');
      }

      // Log the structure of the response
      print('Response keys: ${responseData.keys.toList()}');
      print('Has success key: ${responseData.containsKey('success')}');
      print('Has count key: ${responseData.containsKey('count')}');
      print('Has cars key: ${responseData.containsKey('cars')}');

      if (responseData.containsKey('cars')) {
        print('Cars data type: ${responseData['cars'].runtimeType}');
        if (responseData['cars'] is List) {
          print('Cars list length: ${(responseData['cars'] as List).length}');
        }
      }

      // Parse the response using AllVehicleResponse
      final allVehicleResponse = AllVehicleResponse.fromJson(responseData);

      if (allVehicleResponse.success) {
        // IMPORTANT: Use .cars not .vehicles (based on your API response)
        vehicles.assignAll(allVehicleResponse.vehicles);
        count.value = allVehicleResponse.count;

        // Debug: print details
        print('Successfully loaded ${vehicles.length} vehicles');

        if (vehicles.isNotEmpty) {
          final firstVehicle = vehicles.first;
          print('=== First Vehicle Details ===');
          print('ID: ${firstVehicle.id}');
          print('Brand: ${firstVehicle.model.brand?.name ?? "N/A"}');
          print('Model: ${firstVehicle.model.name}');
          print('Price: ${firstVehicle.pricePerHour}');
          print('Status: ${firstVehicle.status}');
          print('Images count: ${firstVehicle.imagesPaths?.length ?? 0}');
          if (firstVehicle.imagesPaths != null && firstVehicle.imagesPaths!.isNotEmpty) {
            print('First image path: ${firstVehicle.imagesPaths!.first}');
          }
        }
      } else {
        errorMessage.value = 'API returned success: false';
        print('API returned success: false');
      }

      print('=== End Fetch ===');

    } on DioException catch (e) {
      print('=== Dio Error ===');
      print('Error type: ${e.type}');
      print('Error message: ${e.message}');
      print('Status Code: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');

      // Extract error message
      String errorMsg = 'Server error occurred';
      if (e.response?.data != null) {
        if (e.response!.data is Map<String, dynamic>) {
          errorMsg = e.response!.data['message']?.toString() ??
              e.response!.data['error']?.toString() ??
              'Server error: ${e.message}';
        } else if (e.response!.data is String) {
          errorMsg = e.response!.data;
        }
      } else {
        errorMsg = 'Network error: ${e.message}';
      }

      errorMessage.value = errorMsg;
      print('Error message set to: $errorMsg');

    } on FormatException catch (e) {
      print('=== Format Error ===');
      print('Error: $e');
      errorMessage.value = 'Invalid response format from server: $e';

    } catch (e, stackTrace) {
      print('=== Unexpected Error ===');
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      errorMessage.value = 'Unexpected error occurred: $e';

    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Refresh data (pull-to-refresh)
  Future<void> refreshData() async {
    await fetchAgencyCars();
  }

  /// ✅ Add a new vehicle to the list (for immediate UI update after adding)
  void addNewVehicleToList(VehicleBasicDetailsModle vehicle) {
    vehicles.insert(0, vehicle); // Add at the beginning (most recent first)
    count.value = vehicles.length;
    vehicles.refresh(); // Notify listeners
    print('Added new vehicle to list. Total: ${vehicles.length}');
  }

  /// ✅ Remove a vehicle from the list
  void removeVehicleFromList(int vehicleId) {
    final initialCount = vehicles.length;
    vehicles.removeWhere((vehicle) => vehicle.id == vehicleId);
    count.value = vehicles.length;
    vehicles.refresh(); // Notify listeners
    print('Removed vehicle $vehicleId. Before: $initialCount, After: ${vehicles.length}');
  }

  /// ✅ Update a vehicle in the list
  void updateVehicleInList(VehicleBasicDetailsModle updatedVehicle) {
    final index = vehicles.indexWhere((v) => v.id == updatedVehicle.id);
    if (index != -1) {
      vehicles[index] = updatedVehicle;
      vehicles.refresh(); // Notify listeners
      print('Updated vehicle ${updatedVehicle.id} at index $index');
    } else {
      print('Vehicle ${updatedVehicle.id} not found in list');
    }
  }

  /// ✅ Get vehicle by ID
  VehicleBasicDetailsModle? getVehicleById(int id) {
    return vehicles.firstWhereOrNull((vehicle) => vehicle.id == id);
  }

  /// ✅ Filter vehicles by status
  List<VehicleBasicDetailsModle> getVehiclesByStatus(String status) {
    return vehicles.where((vehicle) => vehicle.status == status).toList();
  }

  /// ✅ Filter vehicles by search query
  List<VehicleBasicDetailsModle> searchVehicles(String query) {
    if (query.isEmpty) return vehicles.toList();

    final lowerQuery = query.toLowerCase();
    return vehicles.where((vehicle) {
      final brandName = vehicle.model.brand?.name?.toLowerCase() ?? '';
      final modelName = vehicle.model.name.toLowerCase();
      final registration = vehicle.registrationNumber.toLowerCase();

      return brandName.contains(lowerQuery) ||
          modelName.contains(lowerQuery) ||
          registration.contains(lowerQuery);
    }).toList();
  }

  /// ✅ Clear all vehicles
  void clearVehicles() {
    vehicles.clear();
    count.value = 0;
    vehicles.refresh();
    print('Cleared all vehicles');
  }
}