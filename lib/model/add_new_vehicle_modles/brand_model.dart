class BrandModel {
  final int id;
  final String name;
  final String type;
  final String country;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  BrandModel({
    required this.id,
    required this.name,
    required this.type,
    required this.country,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      country: json['country'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }
}

class BrandResponseModel {
  final bool success;
  final List<BrandModel> brands;

  BrandResponseModel({
    required this.success,
    required this.brands,
  });

  factory BrandResponseModel.fromJson(Map<String, dynamic> json) {
    return BrandResponseModel(
      success: json['success'] ?? false,
      brands: (json['brand'] as List<dynamic>? ?? [])
          .map((e) => BrandModel.fromJson(e))
          .toList(),
    );
  }
}
