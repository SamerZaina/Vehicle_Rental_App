// in this class , we have modle of the company that create the vehicle
// for example : kia - bmw ..ect
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
    return VehicleBrandCompany(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      country: json['country'],
    );
  }
}
