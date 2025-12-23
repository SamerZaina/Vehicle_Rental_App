class VehicleTypeResponse {
  final bool success;
  final List<String> carsType;

  VehicleTypeResponse({
    required this.success,
    required this.carsType,
  });

  factory VehicleTypeResponse.fromJson(Map<String, dynamic> json) {
    return VehicleTypeResponse(
      success: json['success'],
      carsType: List<String>.from(json['cars_type']),
    );
  }
}
