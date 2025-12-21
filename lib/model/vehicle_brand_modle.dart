


// here we have modle for the model on the vehicle :
// if we have bmw , it's modle is m4 for example
import 'package:vehicle_rental_app/model/vehicle_brand_company.dart';

class VehicleBrandModel {
  final int id;
  final int brandId;
  final String name;
  final String year;
  final VehicleBrandCompany brand;

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
      brand: VehicleBrandCompany.fromJson(json['brand']),
    );
  }
}
