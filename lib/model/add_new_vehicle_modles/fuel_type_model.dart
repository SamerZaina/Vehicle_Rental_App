class FuelTypeModel {
  final bool success;
  final List<String> fuelTypes;

  FuelTypeModel({
    required this.success,
    required this.fuelTypes,
  });

  factory FuelTypeModel.fromJson(Map<String, dynamic> json) {
    return FuelTypeModel(
      success: json['success'] as bool,
      fuelTypes: List<String>.from(json['fuel_type']),
    );
  }
}
