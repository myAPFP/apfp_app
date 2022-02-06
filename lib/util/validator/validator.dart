import 'package:flutter/cupertino.dart';

class Validator {
  /// Matches any string containing only letters (lowercase & uppercase)
  static RegExp _validActivityName = new RegExp(r'^[a-zA-Z\s]+$');

  /// Matches positive double, int, and float values
  static RegExp _numeric =
      new RegExp(r'^[+]?([0-9]|[1-9][0-9]|100)*\.?[0-9]+$');

  /// Matches most names, including those that contains spaces
  static RegExp _validNameRegex =
      new RegExp(r"^[\w'\-][^,.0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{1,}$");

  /// Matches numbers in XXX-XXX-XXXX format
  static RegExp _validPhoneRegex = new RegExp(r"\d{3}-\d{3}-\d{4}");

  /// Matches valid email addresses
  static RegExp _validEmailRegex = new RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  ///  Matches passwords with at least:
  ///    - 8 characters
  ///    - One letter
  ///    - One number
  ///    - One special character
  static RegExp validPasswordRegex = new RegExp(
      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$");

  static bool isValidDuration(String duration) {
    return _numeric.hasMatch(duration);
  }

  static bool isValidActivity(String activityName) {
    return _validActivityName.hasMatch(activityName);
  }

  static bool isValidName(String name) {
    return _validNameRegex.hasMatch(name);
  }

  static bool isValidPhone(String phone) {
    if (phone.length != 12) return false;
    return _validPhoneRegex.hasMatch(phone);
  }

  static bool isValidEmail(String email) {
    return _validEmailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return validPasswordRegex.hasMatch(password);
  }

  static bool textFieldHasValue(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }
}
