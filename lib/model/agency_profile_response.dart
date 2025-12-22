import 'package:vehicle_rental_app/model/agency_profile_model.dart';

class AgencyProfileResponse {
  final String status;
  final bool success;
  final AgencyProfileModel agency;

  AgencyProfileResponse({
    required this.status,
    required this.success,
    required this.agency,
  });

  factory AgencyProfileResponse.fromJson(Map<String, dynamic> json) {
    return AgencyProfileResponse(
      status: json['status'].toString(),
      success: json['success'],
      agency: AgencyProfileModel.fromJson(json['agency']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "success": success,
      "agency": agency.toJson(),
    };
  }
}
