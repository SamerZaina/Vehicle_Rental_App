
// here we have model for the model on the vehicle :
// if we have bmw , it's model is m4 for example
// vehicle_brand_modle.dart

class VehicleBrandModel {
  final int id;
  final int brandId;
  final String name;
  final String year;
  final Brand brand; // Changed from VehicleBrandModel? to Brand

  VehicleBrandModel({
    required this.id,
    required this.brandId,
    required this.name,
    required this.year,
    required this.brand,
  });

  factory VehicleBrandModel.fromJson(Map<String, dynamic> json) {
    // ✅ FIX: Add null safety with default values
    return VehicleBrandModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      brandId: (json['brand_id'] as num?)?.toInt() ?? 0,
      name: (json['name'] as String?)?.trim() ?? 'غير معروف',
      year: (json['year'] as String?)?.trim() ?? '2024',
      // ✅ FIX: Safely parse brand with null check
      brand: Brand.fromJson(json['brand']),
    );
  }

  // ✅ FIX: Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brandId': brandId,
      'name': name,
      'year': year,
      'brand': brand.toJson(),
    };
  }
}

class Brand {
  final int id;
  final String name;
  final String type;
  final String country;

  Brand({
    required this.id,
    required this.name,
    required this.type,
    required this.country,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    // ✅ FIX: Add null safety with default values
    return Brand(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] as String?)?.trim() ?? 'غير معروف',
      type: (json['type'] as String?)?.trim() ?? 'سيارة',
      country: (json['country'] as String?)?.trim() ?? 'غير معروف',
    );
  }

  // ✅ FIX: Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'country': country,
    };
  }
}