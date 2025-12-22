


// here we have modle for the model on the vehicle :
// if we have bmw , it's modle is m4 for example
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
    return VehicleBrandModel(
      id: json['id'],
      brandId: json['brand_id'],
      name: json['name'],
      year: json['year'],
      brand: Brand.fromJson(json['brand']), // Extract brand data
    );
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
    return Brand(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      country: json['country'],
    );
  }
}
