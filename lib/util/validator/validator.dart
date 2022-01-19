import 'package:flutter/cupertino.dart';

class Validator {
  // Matches most names, including those that contains spaces
  RegExp validNameRegex =
      new RegExp(r"^[\w'\-][^,.0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{1,}$");

  // Matches numbers in XXX-XXX-XXXX format
  RegExp validPhoneRegex = new RegExp(r"\d{3}-\d{3}-\d{4}");

  // Matches valid email addresses
  RegExp validEmailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}" +
          r"[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  /* 
    Matches passwords with at least:
      8 characters
      One letter
      One number 
      One special character
  */
  RegExp validPasswordRegex = new RegExp(
      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$");

  bool isValidName(String name) {
    return validNameRegex.hasMatch(name);
  }

  bool isValidPhone(String phone) {
    if (phone.length != 12) return false;
    return validPhoneRegex.hasMatch(phone);
  }

  bool isValidEmail(String email) {
    return validEmailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    return validPasswordRegex.hasMatch(password);
  }

  static bool textFieldHasValue(TextEditingController controller) {
    return controller.text != "";
  }
}
