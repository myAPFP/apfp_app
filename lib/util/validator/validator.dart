// Copyright 2022 The myAPFP Authors. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:profanity_filter/profanity_filter.dart';

class Validator {
  /// A _filter with the default list of profanity.
  static final _filter = ProfanityFilter();

  /// Matches any string containing only letters (lowercase & uppercase).
  static RegExp _validActivityNameRegex = new RegExp(r'^[a-zA-Z\s]+$');

  /// Matches positive integers, doubles.
  static RegExp _numRegex = new RegExp(r'^[+]?\d+([.]\d+)?$');

  /// Matches most names, including those that contains spaces.
  static RegExp _validNameRegex =
      new RegExp(r"^[\w'\-][^,.0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{1,}$");

  /// Matches valid email addresses.
  static RegExp _validEmailRegex = new RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  ///  Matches passwords with at least:
  ///    - 8 characters
  ///    - One letter
  ///    - One number
  ///    - One special character
  static RegExp _validPasswordRegex = new RegExp(
      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$");

  /// Returns true if [numStr] is a positive integer greater than 1.
  static bool isPositiveInt(String numStr) {
    int? integer = int.tryParse(numStr);
    if (integer == null || integer < 0) {
      return false;
    }
    return true;
  }

  /// Returns true if [numStr] is a number.
  static bool isNumeric(String numStr) {
    return _numRegex.hasMatch(numStr);
  }

  /// Returns true if the [activityName] contains only letters (lowercase & uppercase).
  static bool isValidActivityName(String activityName) {
    return _validActivityNameRegex.hasMatch(activityName);
  }

  /// Returns true if [name] is a valid name.
  static bool isValidName(String name) {
    return _validNameRegex.hasMatch(name);
  }

  /// Returns true if [email] is a valid email address.
  static bool isValidEmail(String email) {
    return _validEmailRegex.hasMatch(email);
  }

  /// Returns true if [password] satisfies password requirements.
  static bool isValidPassword(String password) {
    return _validPasswordRegex.hasMatch(password);
  }

  /// Returns true if the text field associated with the [controller]
  /// has a value.
  static bool textFieldHasValue(TextEditingController controller) {
    return controller.text.isNotEmpty;
  }

  /// Returns true if [input] contains profanity.
  static bool hasProfanity(String input) {
    return _filter.hasProfanity(input);
  }
}
