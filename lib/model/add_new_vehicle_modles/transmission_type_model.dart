class TransmissionResponse {
  final bool success;
  final List<String> transmission;

  TransmissionResponse({
    required this.success,
    required this.transmission,
  });

  factory TransmissionResponse.fromJson(Map<String, dynamic> json) {
    return TransmissionResponse(
      success: json['success'] ?? false,
      transmission: List<String>.from(json['transmission'] ?? []),
    );
  }
}
