class UserModel {
  final int id;
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
    this.contactEmail,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final customer = json['customer'];
    final agency = json['agency'];

    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      role: json['role'] ?? 'customer',
      isActive: json['is_active'] == true || json['is_active'] == 1,
      isApproved: json['is_approved'] == true || json['is_approved'] == 1,
      address: json['address'],
      drivingLicense: customer != null ? customer['driving_license'] : null,
      commercialRegister:
      agency != null ? agency['commercial_register'] : null,
      contactEmail:
      agency != null ? agency['contact_email'] : null,
    );
  }


}
