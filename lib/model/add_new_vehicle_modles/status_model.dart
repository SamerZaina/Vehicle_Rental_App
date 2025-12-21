class VehicleStatusModel {
  final bool success;
  final List<String> status;

  VehicleStatusModel({
    required this.success,
    required this.status,
  });

  factory VehicleStatusModel.fromJson(Map<String, dynamic> json) {
    return VehicleStatusModel(
      success: json['success'],
      status: List<String>.from(json['status']),
    );
  }
}
