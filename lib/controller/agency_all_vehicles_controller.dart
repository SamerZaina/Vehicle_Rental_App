import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '../api_service/api_service.dart';
import 'package:vehicle_rental_app/model/vehicle_basic_details_modle.dart';
import '../model/vehicle_response.dart';

class AgencyCarsController extends GetxController {
  final ApiService apiService = ApiService();

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

  /// ✅ Fetch all agency cars (GET)
  Future<void> fetchAgencyCars() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      isSearching.value = false;

      final response = await apiService.dio.get(carsUrl);

      Map<String, dynamic> responseData;

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

      final allVehicleResponse = AllVehicleResponse.fromJson(responseData);

      if (allVehicleResponse.success) {
        allVehicles.assignAll(allVehicleResponse.vehicles);
        count.value = allVehicleResponse.count;
        filteredVehicles.clear(); // Clear any previous filters
      } else {
        errorMessage.value = 'API returned success: false';
      }

    } on DioException catch (e) {
      print('Dio Error in fetchAgencyCars: $e');
      print('Status Code: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');
      errorMessage.value =
          e.response?.data['message']?.toString() ??
              'Server error occurred: ${e.message}';

    } on FormatException catch (e) {
      print('Format Error: $e');
      errorMessage.value = 'Invalid response format: $e';

    } catch (e, stackTrace) {
      print('Unexpected Error: $e');
      print('Stack Trace: $stackTrace');
      errorMessage.value = 'Unexpected error occurred: $e';

    } finally {
      isLoading.value = false;
    }
  }

  /// 🔍 Search vehicles using API endpoint
  Future<void> searchVehicles(String query) async {
    try {
      searchQuery.value = query;

      // If query is empty and no rating filter, clear search
      if (query.isEmpty && minRating.value == 0) {
        filteredVehicles.clear();
        isSearching.value = false;
        return;
      }

      isSearching.value = true;
      errorMessage.value = '';

      // Build query parameters for search
      final Map<String, dynamic> queryParams = {};

      if (query.isNotEmpty) {
        // You might want to split the query to search in both brand and model
        // Or let backend handle it based on your API design
        queryParams['brand'] = query;
        queryParams['model'] = query; // Send same query for both
      }

      if (minRating.value > 0) {
        queryParams['rating'] = minRating.value.toString();
      }

      print('Searching with params: $queryParams');

      final response = await apiService.dio.get(
        searchUrl,
        queryParameters: queryParams,
      );

      Map<String, dynamic> responseData;

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

      final searchResponse = AllVehicleResponse.fromJson(responseData);

      if (searchResponse.success) {
        filteredVehicles.assignAll(searchResponse.vehicles);
        count.value = searchResponse.vehicles.length;
        print('Search found ${searchResponse.vehicles.length} vehicles');
      } else {
        errorMessage.value = 'Search returned no results';
        filteredVehicles.clear();
      }

    } on DioException catch (e) {
      print('Dio Error in searchVehicles: $e');
      print('Status Code: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');

      // If search endpoint fails, fall back to local filtering
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
    }
  }

  /// 🔄 Apply filters locally (fallback when API fails)
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
    isSearching.value = result.isNotEmpty &&
        (searchQuery.value.isNotEmpty || minRating.value > 0);
  }

  /// 🧹 Clear all filters
  void clearFilters() {
    searchQuery.value = '';
    minRating.value = 0.0;
    filteredVehicles.clear();
    isSearching.value = false;
    errorMessage.value = '';
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

  /// Add a new vehicle to the list
  void addNewVehicleToList(VehicleBasicDetailsModle vehicle) {
    allVehicles.insert(0, vehicle);
    count.value = allVehicles.length;

    // If we're currently searching, check if new vehicle matches filters
    if (isSearching.value || filteredVehicles.isNotEmpty) {
      if (_matchesCurrentFilters(vehicle)) {
        filteredVehicles.insert(0, vehicle);
      }
    }
  }

  /// Check if vehicle matches current filters
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

  /// Remove a vehicle from the list
  void removeVehicleFromList(int vehicleId) {
    allVehicles.removeWhere((vehicle) => vehicle.id == vehicleId);
    filteredVehicles.removeWhere((vehicle) => vehicle.id == vehicleId);
    count.value = allVehicles.length;
  }

  /// Update a vehicle in the list
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
        }
      } else if (_matchesCurrentFilters(updatedVehicle)) {
        filteredVehicles.add(updatedVehicle);
      }
    }
  }

  /// Get active filters count
  int get activeFiltersCount {
    int count = 0;
    if (searchQuery.value.isNotEmpty) count++;
    if (minRating.value > 0) count++;
    return count;
  }

  /// Check if currently searching
  bool get isFiltering {
    return isSearching.value || filteredVehicles.isNotEmpty;
  }
}