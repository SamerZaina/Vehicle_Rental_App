// in this class , we have model of the company that create the vehicle
// for example : kia - bmw ..etc
// also we have the country of the company (brand)

class VehicleBrandCompany {
  final int id;
  final String name;
  final String type;
  final String country;

  VehicleBrandCompany({
    required this.id,
    required this.name,
    required this.type,
    required this.country,
  });

  factory VehicleBrandCompany.fromJson(Map<String, dynamic> json) {
    // ✅ FIX: Add null safety with default values
    return VehicleBrandCompany(
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