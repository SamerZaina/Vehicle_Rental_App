
import 'package:vehicle_rental_app/agency/model/vehicle_basic_details_modle.dart';
import 'package:vehicle_rental_app/model/vehicle_basic_details_modle.dart';

// this response of the all cars we have in the agency
// here we can know the number of vehicle in our agency
// also , list of all vehicles

/*
*   Vehicle Response
*     -> vehicle basic details
*           -> vehicle
*
* */

class AllVehicleResponse {
  final bool success;
  final int count;
  final List<VehicleBasicDetailsModle> vehicles;

  AllVehicleResponse({
    required this.success,
    required this.count,
    required this.vehicles,
  });

  factory AllVehicleResponse.fromJson(Map<String, dynamic> json) {
    // ✅ FIX: Handle null success field with default value
    final bool successValue = json['success'] as bool? ?? true;

    // ✅ FIX: Handle null count field with default value
    final int countValue = (json['count'] as num?)?.toInt() ?? 0;

    // ✅ FIX: Safely handle vehicles/cars list (can be null or empty)
    List<dynamic> vehiclesData = json['cars'] as List<dynamic>;



    // ✅ FIX: Parse vehicles safely with null checks
    final List<VehicleBasicDetailsModle> vehiclesList = [];

    for (var item in vehiclesData) {
      try {
        if (item is Map<String, dynamic>) {
          final vehicle = VehicleBasicDetailsModle.fromJson(item);
          vehiclesList.add(vehicle);
        }
      } catch (e) {
        print('Error parsing vehicle item: $e');
        // Skip this item but continue parsing others
      }
    }

    return AllVehicleResponse(
      success: successValue,
      count: countValue,
      vehicles: vehiclesList,
    );
  }

  // Helper method for debugging
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'count': count,
      'vehicles': vehicles.map((v) => v.toJson()).toList(),
    };
  }
}
