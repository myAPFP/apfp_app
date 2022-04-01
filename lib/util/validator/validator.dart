import 'package:flutter/cupertino.dart';
import 'package:profanity_filter/profanity_filter.dart';

class Validator {
  static final filter = ProfanityFilter();

  /// Matches any string containing only letters (lowercase & uppercase)
  static RegExp _validActivityNameRegex = new RegExp(r'^[a-zA-Z\s]+$');

  /// Matches positive integers >= 0
  static RegExp _integerRegex = new RegExp(r'^[1-9]\d*$');

  /// Matches postive ints, doubles
  static RegExp _numRegex = new RegExp(
      r'^[+]?\d+([.]\d+)?$');

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

  static bool isInt(String num) {
    return _integerRegex.hasMatch(num);
  }

  static bool isNumeric(String num) {
    return _numRegex.hasMatch(num);
  }

  static bool isValidActivity(String activityName) {
    return _validActivityNameRegex.hasMatch(activityName);
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

  static bool hasProfanity(String input) {
    return filter.hasProfanity(input);
  }
}
