
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
    // ✅ FIX: Add null safety with default values for all required fields
    return VehicleBasicDetailsModle(
      id: (json['id'] as num?)?.toInt() ?? 0,
      agencyId: (json['agency_id'] as num?)?.toInt() ?? 0,
      modelId: (json['model_id'] as num?)?.toInt() ?? 0,
      registrationNumber: (json['registration_number'] as String?)?.trim() ?? '',
      pricePerHour: (json['price_per_hour']?.toString() ?? '0').trim(),
      color: (json['color'] as String?)?.trim() ?? '',
      fuelType: (json['fuel_type'] as String?)?.trim() ?? '',
      seats: (json['seats'] as num?)?.toInt() ?? 0,
      doors: (json['doors'] as num?)?.toInt() ?? 0,
      transmission: (json['transmission'] as String?)?.trim() ?? '',
      status: (json['status'] as String?)?.trim() ?? 'available',
      description: (json['description'] as String?)?.trim(),
      isFeatured: json['is_featured'] as bool? ?? false,
      rate: _parseRating(json['reviews_avg_rating']),
      // ✅ FIX: Safely parse model with null check and fallback
      model: _parseVehicleModel(json['model']),
      imagesPaths: _parseImagesPaths(json['images_paths']),
    );
  }

  // ✅ FIX: Helper method to parse rating safely
  static String? _parseRating(dynamic ratingData) {
    if (ratingData == null) return null;

    if (ratingData is String) {
      return ratingData.trim();
    } else if (ratingData is num) {
      return ratingData.toString();
    } else if (ratingData is double) {
      return ratingData.toStringAsFixed(1);
    }

    return ratingData.toString();
  }

  // ✅ FIX: Helper method to parse vehicle model safely
  static VehicleBrandModel _parseVehicleModel(dynamic modelData) {
    try {
      if (modelData is Map<String, dynamic>) {
        return VehicleBrandModel.fromJson(modelData);
      }
    } catch (e) {
      print('Error parsing vehicle model: $e');
    }

    // Return a default model if parsing fails
    return VehicleBrandModel(
      id: 0,
      brandId: 0,
      name: 'غير معروف',
      year: '2024',
      brand: Brand(
        id: 0,
        name: 'غير معروف',
        type: 'سيارة',
        country: 'غير معروف',
      ),
    );
  }

  // ✅ FIX: Helper method to parse images_paths with better null safety
  static List<String>? _parseImagesPaths(dynamic imagesData) {
    if (imagesData == null) return null;

    try {
      if (imagesData is String) {
        // If it's a string, check if it's JSON or comma-separated
        final trimmedData = imagesData.trim();

        if (trimmedData.isEmpty) return null;

        if (trimmedData.startsWith('[')) {
          // It's a JSON string, parse it
          try {
            final parsed = jsonDecode(trimmedData) as List;
            return List<String>.from(
                parsed.map((e) => _cleanImagePath(e.toString()))
            );
          } catch (e) {
            // If parsing fails, try to clean and return as single item
            return [_cleanImagePath(trimmedData)];
          }
        } else if (trimmedData.contains(',')) {
          // Comma-separated string
          return trimmedData.split(',')
              .map((e) => _cleanImagePath(e.trim()))
              .where((path) => path.isNotEmpty)
              .toList();
        } else {
          // Single string
          return [_cleanImagePath(trimmedData)];
        }
      } else if (imagesData is List) {
        // Already a list
        return List<String>.from(
            imagesData.map((e) => _cleanImagePath(e.toString()))
                .where((path) => path.isNotEmpty)
        );
      }
    } catch (e) {
      print('Error parsing images_paths: $e');
    }

    return null;
  }

  // ✅ FIX: Helper to clean image paths (remove escaped slashes)
  static String _cleanImagePath(String path) {
    if (path.isEmpty) return path;

    // Clean the path
    String cleanedPath = path
        .replaceAll('\\/', '/')  // Fix escaped slashes
        .replaceAll('"', '')     // Remove quotes
        .replaceAll("'", '')     // Remove single quotes
        .trim();

    // Remove any surrounding brackets
    if (cleanedPath.startsWith('[') && cleanedPath.endsWith(']')) {
      cleanedPath = cleanedPath.substring(1, cleanedPath.length - 1);
    }

    return cleanedPath;
  }

  // ✅ FIX: Add toJson method for debugging
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'agencyId': agencyId,
      'modelId': modelId,
      'registrationNumber': registrationNumber,
      'pricePerHour': pricePerHour,
      'color': color,
      'fuelType': fuelType,
      'seats': seats,
      'doors': doors,
      'transmission': transmission,
      'status': status,
      'description': description,
      'isFeatured': isFeatured,
      'model': model.toJson(),
      'rate': rate,
      'imagesPaths': imagesPaths,
    };
  }
}
