import 'package:flutter/cupertino.dart';

class Validator {
  /// Extracts activity data from a paddedActivityCard
  static RegExp _cardToStrRegex = new RegExp(r'\[<(.*?)\>]');

  /// Matches any string containing only letters (lowercase & uppercase)
  static RegExp _validActivityNameRegex = new RegExp(r'^[a-zA-Z\s]+$');

  /// Matches positive double, int, and float values >= 0
  static RegExp _numericRegex =
      new RegExp(r'^[+]?([0-9]|[0-9][0-9]|100)*\.?[0-9]+$');

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

  static List<String>? cardInfoToList(Padding paddedActivityCard) {
    final match = _cardToStrRegex.firstMatch(paddedActivityCard.toString());
    return match!.group(0)!.substring(3, match.group(0)!.length - 3).split(' ');
  }

  static bool isValidDuration(String duration) {
    return _numericRegex.hasMatch(duration);
  }

  static bool isValidActivity(String activityName) {
    return _validActivityNameRegex.hasMatch(activityName);
  }


  static bool isValidName(String name) {
    return _validNameRegex.hasMatch(name);
  }

  /// Matches numbers in XXX-XXX-XXXX format.
  ///
  /// Example: 219-219-2192
  static RegExp _validPhoneRegex = new RegExp(r"\d{3}-\d{3}-\d{4}");

  /// Uses [_validPhoneRegex] to validate the passed in string.
  /// 
  /// Returns true if string matches [_validPhoneRegex]. Otherwise, returns false.
  static bool isValidPhone(String phone) {
    if (phone.length != 12) return false;
    return _validPhoneRegex.hasMatch(phone);
  }

  /// Matches valid email addresses.
  ///
  /// Example: example@gmail.com.
  static RegExp _validEmailRegex = new RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  /// Uses [_validEmailRegex] to validate the passed in string.
  /// 
  /// Returns true if string matches [_validEmailRegex]. Otherwise, returns false.
  static bool isValidEmail(String email) {
    return _validEmailRegex.hasMatch(email);
  }

  ///  Matches passwords with at least:
  ///    - 8 characters
  ///    - One letter
  ///    - One number
  ///    - One special character
  ///
  /// Example: !password12
  static RegExp _validPasswordRegex = new RegExp(
      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[_@$!%*#?&])[A-Za-z\d_@$!%*#?&]{8,}$");

  /// Uses [_validPasswordRegex] to validate the passed in string.
  /// 
  /// Returns true if string matches [_validPasswordRegex]. Otherwise, returns false.
  static bool isValidPassword(String password) {
    return _validPasswordRegex.hasMatch(password);
  }

  static bool textFieldHasValue(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }
}
