class VehicleModel {
  final int id;
  final int brandId;
  final String name;
  final String year;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  VehicleModel({
    required this.id,
    required this.brandId,
    required this.name,
    required this.year,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] ?? 0,
      brandId: json['brand_id'] ?? 0,
      name: json['name'] ?? '',
      year: json['year'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }
}

class VehicleModelResponse {
  final bool success;
  final List<VehicleModel> models;

  VehicleModelResponse({
    required this.success,
    required this.models,
  });

  factory VehicleModelResponse.fromJson(Map<String, dynamic> json) {
    return VehicleModelResponse(
      success: json['success'] ?? false,
      models: (json['models'] as List<dynamic>? ?? [])
          .map((e) => VehicleModel.fromJson(e))
          .toList(),
    );
  }
}
