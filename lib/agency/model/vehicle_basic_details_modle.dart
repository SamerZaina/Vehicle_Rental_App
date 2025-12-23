import 'dart:convert';

import 'package:vehicle_rental_app/agency/model/vehicle_brand_modle.dart';


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
      isFeatured: json['is_featured'] ?? false,
      rate: json['reviews_avg_rating']?.toString(),
      model: VehicleBrandModel.fromJson(json['model']),
      imagesPaths: _parseImagesPaths(json['images_paths']), // Updated
    );
  }

  // Helper method to parse images_paths
  static List<String>? _parseImagesPaths(dynamic imagesData) {
    if (imagesData == null) return null;

    if (imagesData is String) {
      // If it's a string, check if it's JSON or comma-separated
      if (imagesData.startsWith('[')) {
        // It's a JSON string, parse it
        try {
          final parsed = jsonDecode(imagesData) as List;
          return List<String>.from(parsed.map((e) => e.toString()));
        } catch (e) {
          // If parsing fails, return as single item list
          return [imagesData];
        }
      } else if (imagesData.contains(',')) {
        // Comma-separated string
        return imagesData.split(',').map((e) => e.trim()).toList();
      } else {
        // Single string
        return [imagesData];
      }
    } else if (imagesData is List) {
      // Already a list
      return List<String>.from(imagesData.map((e) => e.toString()));
    }

    return null;
  }
}