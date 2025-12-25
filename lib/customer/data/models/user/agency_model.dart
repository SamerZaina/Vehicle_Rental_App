class AgencyModel {
  final int id;
  final String agencyName;
  final String? contactEmail;
  final String phone;
  final String? profileImage;
  final String address;

  AgencyModel({
    required this.id,
    required this.agencyName,
    required this.contactEmail,
    required this.phone,
    this.profileImage,
    required this.address,
  });

  factory AgencyModel.fromJson(Map<String , dynamic> json) {
    return AgencyModel(
        id: json['id'],
        agencyName: json['agency_name'] ?? '',
        contactEmail: json['contact_email']??'',
        phone: json['phone'] ?? '',
        profileImage:json['profile_image'],
        address:  json['address']??'');
  }
}
