

import 'package:vehicle_rental_app/model/vehicle_brand_modle.dart' show VehicleModel, VehicleBrandModel;


// in this class , we have the basic details of the vehicle like :
    // -> price
    // -> fuel type
    // -> doors ....and more , which is common to all vehicle



class VehicleBasicDetailsModle {
  final int id;
  final int agencyId;
  final int modelId;
  final String registrationNumber;
  final String pricePerHour;
  final String color;
  final String fuelType;
  final int seats;
  final int doors;
  final String transmission;
  final String status;
  final String? description;
  final bool isFeatured;
  final VehicleBrandModel model;
  final String? rate;
  final List<String>? imagesPaths;

  VehicleBasicDetailsModle({
    required this.id,
    required this.agencyId,
    required this.modelId,
    required this.registrationNumber,
    required this.pricePerHour,
    required this.color,
    required this.fuelType,
    required this.seats,
    required this.doors,
    required this.transmission,
    required this.status,
    this.description,
    required this.isFeatured,
    required this.model,
    this.rate,
    this.imagesPaths,
  });

  factory VehicleBasicDetailsModle.fromJson(Map<String, dynamic> json) {
    return VehicleBasicDetailsModle(
      id: json['id'],
      agencyId: json['agency_id'],
      modelId: json['model_id'],
      registrationNumber: json['registration_number'],
      pricePerHour: json['price_per_hour'],
      color: json['color'],
      fuelType: json['fuel_type'],
      seats: json['seats'],
      doors: json['doors'],
      transmission: json['transmission'],
      status: json['status'],
      description: json['description'],
      isFeatured: json['is_featured'] ?? false, // Added default value
      rate: json['reviews_avg_rating']?.toString(),
      model: VehicleBrandModel.fromJson(json['model']),
      imagesPaths: json['images_paths'] != null
          ? List<String>.from(json['images_paths'])
          : null,
    );
  }
}