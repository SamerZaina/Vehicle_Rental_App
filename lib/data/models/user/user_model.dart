class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String role;
  final bool isActive;
  final bool isApproved;
  final String? profilePhotoPath;
  final String? address;

  final String? drivingLicense; // for customer
  final String? commercialRegister; // for agencies
  final String? commercialRegisterNumber; // for agencies

  final String? contactEmail;

  UserModel({
     required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
    required this.isActive,
    required this.isApproved,
    this.profilePhotoPath,
    this.address,
    this.drivingLicense,
    this.commercialRegister,
     this.commercialRegisterNumber,

    this.contactEmail,
  });

  bool get isCustomer => role == 'customer';
  bool get isAgency   => role == 'agency';

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone']??'',
      role: json['agency'] != null ? 'agency':(json['user']!= null ? 'customer' :json['role']) ?? '',
      profilePhotoPath: (json['profile_image']??'').toString(),
      isActive: json['is_active'] == true || json['is_active'] == 1,
      isApproved: json['is_approved'] == true || json['is_approved'] == 1,
      address: json['address'] ?? '',
      drivingLicense:  json['driving_license'].toString(),
      commercialRegister: json['commercial_register']?.toString(),
      commercialRegisterNumber: json['commercial_register_number'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'profile_photo_path':profilePhotoPath,
      'driving_license': drivingLicense,
      'commercial_register': commercialRegister,
      'contact_email': contactEmail,
    };
  }
}
