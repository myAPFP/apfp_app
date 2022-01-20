class Validator {

  // Matches most names, including those that contains spaces
  static RegExp _validNameRegex =
      new RegExp(r"^[\w'\-][^,.0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{1,}$");

  // Matches numbers in XXX-XXX-XXXX format
  static RegExp _validPhoneRegex = new RegExp(r"\d{3}-\d{3}-\d{4}");

  // Matches valid email addresses
  static RegExp _validEmailRegex = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}" +
          r"[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  /* 
    Matches passwords with at least:
      8 characters
      One letter
      One number 
      One special character
  */
  static RegExp validPasswordRegex = new RegExp(
      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$");

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
}