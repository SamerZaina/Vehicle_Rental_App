

// this response of the all cars we have in the agency
// here we can know the number of vehicle in our agency
// also , list of all vehicles

/*
*   Vehicle Response
*     -> vehicle basic details
*           -> vehicle
*
* */

import 'package:vehicle_rental_app/agency/model/vehicle_basic_details_modle.dart';

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
    return AllVehicleResponse(
      success: json['success'] == 1 || json['success'] == true,
      count: json['count'] ?? 0,
      // json['cars'] -> keep it as it's come from json (api response )
      vehicles: (json['cars']as List )
          .map((e) => VehicleBasicDetailsModle.fromJson(e))
          .toList(),
    );
  }
}
