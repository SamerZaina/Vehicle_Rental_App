class AgencyProfileModel {
  final int userId;
  final String agencyName;
  final String email;
  final String phone;
  final String? commercialRegister;
  final String? profileImage;
  final String? commercialRegisterNumber ;


  AgencyProfileModel({
    required this.userId,
    required this.agencyName,
    required this.email,
    required this.phone,
    this.commercialRegister,
    this.profileImage,
    this .commercialRegisterNumber

  });

  factory AgencyProfileModel.fromJson(Map<String, dynamic> json) {
    return AgencyProfileModel(
      userId: json['user_id'],
      agencyName: json['agency_name'],
      email: json['email'],
      phone: json['phone'],
      commercialRegister: json['commercial_register'],
      profileImage: json['profile_image'],
      commercialRegisterNumber: json['commercial_register_number'],


    );
  }


  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "agency_name": agencyName,
      "email": email,
      "phone": phone,
      "commercial_register": commercialRegister,
      "profile_image": profileImage,
      "commercial_register_number" : commercialRegisterNumber
    };
  }
}
