
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/core/dio_client.dart';
import 'dart:convert';
import 'package:vehicle_rental_app/model/vehicle_basic_details_modle.dart';

import '../model/vehicle_basic_details_modle.dart';


class AgencyCarsController extends GetxController {
  final Dio dio = DioClient.dio;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isSearching = false.obs;

  final RxList<VehicleBasicDetailsModle> allVehicles = <VehicleBasicDetailsModle>[].obs;
  final RxList<VehicleBasicDetailsModle> filteredVehicles = <VehicleBasicDetailsModle>[].obs;

  final RxString searchQuery = ''.obs;
  final RxDouble minRating = 0.0.obs;
  final RxInt count = 0.obs;

  // Endpoints
  static const String carsUrl = '/agency/cars';
  static const String searchUrl = '/agency/cars/search';

  @override
  void onInit() {
    super.onInit();
    fetchAgencyCars();
  }

  /// Getter for vehicles list
  List<VehicleBasicDetailsModle> get vehicles {
    return filteredVehicles.isNotEmpty ? filteredVehicles : allVehicles;
  }

  /// ✅ Fetch all agency cars (GET) - FIXED VERSION
  Future<void> fetchAgencyCars() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      isSearching.value = false;

      final response = await dio.get(carsUrl);

      Map<String, dynamic> responseData;

      if (response.data is Map<String, dynamic>) {
        responseData = response.data as Map<String, dynamic>;
      } else if (response.data is String) {
        try {
          responseData = jsonDecode(response.data) as Map<String, dynamic>;
        } catch (e) {
          throw FormatException('Failed to decode JSON string: $e');
        }
      } else {
        throw FormatException('Unexpected response type: ${response.data.runtimeType}');
      }

      // ✅ FIX: Handle response data safely
      final bool success = responseData['success'] as bool? ?? true;

      if (success) {
        // Handle vehicles data
        final vehiclesData = responseData['cars'];

        if (vehiclesData is List) {
          if (vehiclesData.isEmpty) {
            // No vehicles - clear lists
            allVehicles.clear();
            count.value = 0;
            print('No vehicles found for this agency');
          } else {
            try {
              final List<VehicleBasicDetailsModle> vehicles = vehiclesData
                  .where((item) => item is Map<String, dynamic>)
                  .map<VehicleBasicDetailsModle>((vehicleJson) =>
                  VehicleBasicDetailsModle.fromJson(vehicleJson as Map<String, dynamic>))
                  .toList();

              allVehicles.assignAll(vehicles);
              count.value = responseData['count'] as int? ?? vehicles.length;
            } catch (e) {
              print('Error parsing vehicles: $e');
              errorMessage.value = 'Error parsing vehicle data';
              allVehicles.clear();
              count.value = 0;
            }
          }
        } else {
          // vehicles is not a list
          print('Unexpected vehicles data type: ${vehiclesData.runtimeType}');
          allVehicles.clear();
          count.value = 0;
        }

        filteredVehicles.clear(); // Clear any previous filters
      } else {
        // API returned success: false
        final String message = responseData['message'] as String? ??
            'API returned success: false';
        errorMessage.value = message;
        allVehicles.clear();
        count.value = 0;
      }

    } on DioException catch (e) {
      print('Dio Error in fetchAgencyCars: $e');
      print('Status Code: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');

      // Handle specific cases
      if (e.response?.statusCode == 404) {
        // No vehicles found
        allVehicles.clear();
        count.value = 0;
        errorMessage.value = 'لم يتم العثور على مركبات في وكالتك';
      } else {
        errorMessage.value = (e.response?.data is Map
            ? (e.response?.data as Map)['message']?.toString()
            : 'Server error occurred: ${e.message}')!;
      }

    } on FormatException catch (e) {
      print('Format Error: $e');
      errorMessage.value = 'Invalid response format: $e';
      allVehicles.clear();
      count.value = 0;

    } catch (e, stackTrace) {
      print('Unexpected Error: $e');
      print('Stack Trace: $stackTrace');
      errorMessage.value = 'حدث خطأ غير متوقع: $e';
      allVehicles.clear();
      count.value = 0;

    } finally {
      isLoading.value = false;
    }
  }

  /// 🔍 Search vehicles using API endpoint - FIXED VERSION
  Future<void> searchVehicles(String query) async {
    try {
      searchQuery.value = query;

      // If query is empty and no rating filter, clear search
      if (query.isEmpty && minRating.value == 0) {
        filteredVehicles.clear();
        isSearching.value = false;
        count.value = allVehicles.length;
        return;
      }

      isSearching.value = true;
      errorMessage.value = '';

      // Build query parameters for search
      final Map<String, dynamic> queryParams = {};

      if (query.isNotEmpty) {
        queryParams['search'] = query;
      }

      if (minRating.value > 0) {
        queryParams['min_rating'] = minRating.value.toString();
      }

      print('Searching with params: $queryParams');

      final response = await dio.get(
        searchUrl,
        queryParameters: queryParams,
      );

      Map<String, dynamic> responseData;

      if (response.data is Map<String, dynamic>) {
        responseData = response.data as Map<String, dynamic>;
      } else if (response.data is String) {
        try {
          responseData = jsonDecode(response.data) as Map<String, dynamic>;
        } catch (e) {
          throw FormatException('Failed to decode JSON string: $e');
        }
      } else {
        throw FormatException('Unexpected response type: ${response.data.runtimeType}');
      }

      // ✅ FIX: Handle success field safely
      final bool success = responseData['success'] as bool? ?? true;

      if (success) {
        final vehiclesData = responseData['cars'];

        if (vehiclesData is List) {
          if (vehiclesData.isEmpty) {
            filteredVehicles.clear();
            count.value = 0;
            errorMessage.value = 'لم يتم العثور على مركبات تطابق البحث';
          } else {
            try {
              final List<VehicleBasicDetailsModle> vehicles = vehiclesData
                  .where((item) => item is Map<String, dynamic>)
                  .map<VehicleBasicDetailsModle>((vehicleJson) =>
                  VehicleBasicDetailsModle.fromJson(vehicleJson as Map<String, dynamic>))
                  .toList();

              filteredVehicles.assignAll(vehicles);
              count.value = vehicles.length;
              errorMessage.value = ''; // Clear error on success
            } catch (e) {
              print('Error parsing search results: $e');
              errorMessage.value = 'خطأ في معالجة نتائج البحث';
              filteredVehicles.clear();
              count.value = 0;
            }
          }
        } else {
          filteredVehicles.clear();
          count.value = 0;
          errorMessage.value = 'نتائج البحث غير صالحة';
        }
      } else {
        final String message = responseData['message'] as String? ??
            'البحث لم يعطي نتائج';
        errorMessage.value = message;
        filteredVehicles.clear();
        count.value = 0;
      }

    } on DioException catch (e) {
      print('Dio Error in searchVehicles: $e');
      print('Status Code: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');

      // Fall back to local filtering
      print('Falling back to local search...');
      _applyLocalFilters();

    } catch (e, stackTrace) {
      print('Unexpected Error in search: $e');
      print('Stack Trace: $stackTrace');
      _applyLocalFilters();

    } finally {
      isSearching.value = false;
    }
  }

  /// ⭐ Filter vehicles by minimum rating
  void filterByRating(double minRatingValue) {
    minRating.value = minRatingValue;

    // If we have an active search, combine with API
    if (searchQuery.value.isNotEmpty) {
      searchVehicles(searchQuery.value);
    } else if (minRatingValue > 0) {
      // Only rating filter, apply locally
      _applyLocalFilters();
    } else {
      // No filters, clear filtered list
      filteredVehicles.clear();
      isSearching.value = false;
      count.value = allVehicles.length;
    }
  }

  /// 🔧 Apply filters locally (fallback when API fails)
  void _applyLocalFilters() {
    List<VehicleBasicDetailsModle> result = List.from(allVehicles);

    // Apply search filter
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      result = result.where((vehicle) {
        final brandName = vehicle.model.brand?.name?.toLowerCase() ?? '';
        final modelName = vehicle.model.name.toLowerCase();
        final registration = vehicle.registrationNumber.toLowerCase();

        return brandName.contains(query) ||
            modelName.contains(query) ||
            registration.contains(query);
      }).toList();
    }

    // Apply rating filter
    if (minRating.value > 0) {
      result = result.where((vehicle) {
        final rating = double.tryParse(vehicle.rate ?? '0') ?? 0;
        return rating >= minRating.value;
      }).toList();
    }

    filteredVehicles.assignAll(result);
    count.value = result.length;
    isSearching.value = result.isNotEmpty &&
        (searchQuery.value.isNotEmpty || minRating.value > 0);

    // Set error message if no results
    if (result.isEmpty && (searchQuery.value.isNotEmpty || minRating.value > 0)) {
      errorMessage.value = 'لم يتم العثور على مركبات تطابق الفلاتر';
    } else {
      errorMessage.value = '';
    }
  }

  /// 🗑️ Clear all filters
  void clearFilters() {
    searchQuery.value = '';
    minRating.value = 0.0;
    filteredVehicles.clear();
    isSearching.value = false;
    errorMessage.value = '';
    count.value = allVehicles.length;
  }

  /// 🔄 Refresh data
  Future<void> refreshData() async {
    if (isSearching.value || filteredVehicles.isNotEmpty) {
      // If searching, refresh search
      await searchVehicles(searchQuery.value);
    } else {
      // Otherwise, refresh all vehicles
      await fetchAgencyCars();
    }
  }

  /// ➕ Add a new vehicle to the list
  void addNewVehicleToList(VehicleBasicDetailsModle vehicle) {
    allVehicles.insert(0, vehicle);
    count.value = allVehicles.length;

    // If we're currently searching, check if new vehicle matches filters
    if (isSearching.value || filteredVehicles.isNotEmpty) {
      if (_matchesCurrentFilters(vehicle)) {
        filteredVehicles.insert(0, vehicle);
        count.value = filteredVehicles.length;
      }
    }
  }

  /// 🔍 Check if vehicle matches current filters
  bool _matchesCurrentFilters(VehicleBasicDetailsModle vehicle) {
    // Search filter
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      final brandName = vehicle.model.brand?.name?.toLowerCase() ?? '';
      final modelName = vehicle.model.name.toLowerCase();
      final registration = vehicle.registrationNumber.toLowerCase();

      if (!brandName.contains(query) &&
          !modelName.contains(query) &&
          !registration.contains(query)) {
        return false;
      }
    }

    // Rating filter
    if (minRating.value > 0) {
      final rating = double.tryParse(vehicle.rate ?? '0') ?? 0;
      if (rating < minRating.value) {
        return false;
      }
    }

    return true;
  }

  /// ❌ Remove a vehicle from the list
  void removeVehicleFromList(int vehicleId) {
    allVehicles.removeWhere((vehicle) => vehicle.id == vehicleId);
    filteredVehicles.removeWhere((vehicle) => vehicle.id == vehicleId);
    count.value = allVehicles.length;
  }

  /// ✏️ Update a vehicle in the list
  void updateVehicleInList(VehicleBasicDetailsModle updatedVehicle) {
    final index = allVehicles.indexWhere((v) => v.id == updatedVehicle.id);
    if (index != -1) {
      allVehicles[index] = updatedVehicle;

      // Update in filtered list if present
      final filteredIndex = filteredVehicles.indexWhere((v) => v.id == updatedVehicle.id);
      if (filteredIndex != -1) {
        if (_matchesCurrentFilters(updatedVehicle)) {
          filteredVehicles[filteredIndex] = updatedVehicle;
        } else {
          filteredVehicles.removeAt(filteredIndex);
          count.value = filteredVehicles.length;
        }
      } else if (_matchesCurrentFilters(updatedVehicle)) {
        filteredVehicles.add(updatedVehicle);
        count.value = filteredVehicles.length;
      }
    }
  }

  /// 🔢 Get active filters count
  int get activeFiltersCount {
    int count = 0;
    if (searchQuery.value.isNotEmpty) count++;
    if (minRating.value > 0) count++;
    return count;
  }

  /// 🔍 Check if currently searching
  bool get isFiltering {
    return isSearching.value || filteredVehicles.isNotEmpty;
  }
}

