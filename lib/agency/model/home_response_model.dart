
import 'package:vehicle_rental_app/agency/model/vehicle_basic_details_modle.dart';

class HomeVehiclesResponse {
  final bool success;
  final List<VehicleBasicDetailsModle> bestRatingCars;
  final List<VehicleBasicDetailsModle> recentAddedCars;
  final List<VehicleBasicDetailsModle> featuredCars;

  HomeVehiclesResponse({
    required this.success,
    required this.bestRatingCars,
    required this.recentAddedCars,
    required this.featuredCars,
  });

  factory HomeVehiclesResponse.fromJson(Map<String, dynamic> json) {
    List<VehicleBasicDetailsModle> _parse(dynamic list) {
      if (list == null || list is! List) return [];

      return list
          .whereType<Map<String, dynamic>>()
          .map((e) => VehicleBasicDetailsModle.fromJson(e))
          .toList();
    }

    return HomeVehiclesResponse(
      success: json['success'] as bool? ?? true,
      bestRatingCars: _parse(json['best_rating_cars']),
      recentAddedCars: _parse(json['recent_added_cars']),
      featuredCars: _parse(json['featured_cars']),
    );
  }
}
