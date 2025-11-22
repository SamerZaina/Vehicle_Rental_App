class RFormatException implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const RFormatException([this.message = 'An unexpected format error occurred. Please check your input.']);

  /// Create a format exception from a specific error message.
  factory RFormatException.fromMessage(String message) {
    return RFormatException(message);
  }

  /// Get the corresponding error message.
  String get formattedMessage => message;

  /// Create a format exception from a specific error code.
  factory RFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const RFormatException('The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const RFormatException('The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-date-format':
        return const RFormatException('The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const RFormatException('The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const RFormatException('The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numeric-format':
        return const RFormatException('The input should be a valid numeric format.');
      case 'invalid-name-format':
        return const RFormatException('The name format is invalid. Please use only letters and spaces.');
      case 'invalid-username-format':
        return const RFormatException('Username can only contain letters, numbers, and underscores.');
      case 'invalid-password-format':
        return const RFormatException('Password must meet the required security criteria.');
      case 'invalid-postal-code-format':
        return const RFormatException('The postal code format is invalid for your region.');
      case 'invalid-currency-format':
        return const RFormatException('The currency format is invalid.');
      case 'invalid-time-format':
        return const RFormatException('The time format is invalid. Please use HH:MM format.');
      case 'invalid-json-format':
        return const RFormatException('The JSON format is invalid. Please check your input.');
      case 'invalid-xml-format':
        return const RFormatException('The XML format is invalid. Please check your input.');
      case 'invalid-base64-format':
        return const RFormatException('The Base64 format is invalid.');
      case 'invalid-hex-format':
        return const RFormatException('The hexadecimal format is invalid.');
      case 'invalid-uuid-format':
        return const RFormatException('The UUID format is invalid.');
      case 'invalid-ip-format':
        return const RFormatException('The IP address format is invalid.');
      case 'invalid-mac-format':
        return const RFormatException('The MAC address format is invalid.');

      default:
        return const RFormatException('An invalid format was provided. Please check your input.');
    }
  }
}