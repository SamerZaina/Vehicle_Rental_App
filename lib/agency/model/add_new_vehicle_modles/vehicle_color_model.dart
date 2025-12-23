import 'package:flutter/cupertino.dart';

class VehicleColorResponse{
  final bool success;
  final List<String> colors;

  VehicleColorResponse({
    required this.success ,
    required this.colors
});


  factory VehicleColorResponse.fromJson(Map<String, dynamic> json) {
    return VehicleColorResponse(
      success: json['success'] ?? false,
      colors: List<String>.from(json['color'] ?? []),
    );
  }
}