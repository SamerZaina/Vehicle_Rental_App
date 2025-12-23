import 'dart:io';

class CreateVehicleModel {
 // final String type;
  final int modelId;
  final String? transmission;
  final String? color;
  final String? fuelType;
  final String status;
  final String? registrationNumber;
  final int? seats;
  final int? doors;
  final double? pricePerHour;
  final String? description;
  final List<File>? images; // this is list Files type , not string

  CreateVehicleModel({
    //required this.type,
    required this.modelId,
    this.transmission,
    this.color,
    this.fuelType,
    required this.status,
    this.registrationNumber,
    this.seats,
    this.doors,
    this.pricePerHour,
    this.description,
    this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      //"type": type,
      "model_id": modelId,
      "transmission": transmission,
      "color": color,
      "fuel_type": fuelType,
      "status":status,
      "registration_number": registrationNumber,
      "seats": seats,
      "doors" : doors,
      "price_per_hour": pricePerHour,
      "description": description,

    };
  }
}
