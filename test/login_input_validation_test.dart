import 'package:flutter_test/flutter_test.dart';
import 'package:apfp/util/validator/validator.dart';
void main() {
  group("User Verification Testing", () {

    // Name ------------------------------------------------------

    test('Provided name should be a valid name.',() {
      expect(Validator.isValidName("Brandon"), true);
    });

    test('Provided name should be a valid name.', () {
      expect(Validator.isValidName("Wilkins"), true);
    });

    test('Provided name should be a valid name.',() {
      expect(Validator.isValidName("Joe"), true);
    });
    
    test('Provided name should be a valid name.', () {
      expect(Validator.isValidName("Anthon65y"), false);
    });

    test('Provided name should be a valid name.',() {
      expect(Validator.isValidName("Bra 7"), false);
    });

    test('Provided name should be a valid name.', () {
      expect(Validator.isValidName("wilkin;"), false);
    });

    // Phone ------------------------------------------------------

    test('Provided phone number should be a valid phone number.',() {
      expect(Validator.isValidPhone("6542125359"), false);
    });

    test('Provided phone number should be a valid phone number.',() {
      expect(Validator.isValidPhone("(334) 565-3222"), false);
    });

    test('Provided phone number should be a valid phone number.',() {
      expect(Validator.isValidPhone("897-123-2432"), true);
    });

    test('Provided phone number should be a valid phone number.',() {
      expect(Validator.isValidPhone("433-643-7643"), true);
    });

    // Email ------------------------------------------------------

    test('Provided email address should be a valid email address.',() {
      expect(Validator.isValidEmail("jjdoe@bsu.edu"), true);
    });

    test('Provided email address should be a valid email address.',() {
      expect(Validator.isValidEmail("janedoe343@gmail.com"), true);
    });

    test('Provided email address should be a valid email address.',() {
      expect(Validator.isValidEmail("CappyStone495@cappy.!cap"), false);
    });

    test('Provided email address should be a valid email address.',() {
      expect(Validator.isValidEmail("MrSirMan44@a.5.S?"), false);
    });

    // Password ------------------------------------------------------

    test('Provided password should be a valid password.',() {
      expect(Validator.isValidPassword("!password99!"), true);
    });

    test('Provided password should be a valid password.',() {
      expect(Validator.isValidPassword("p"), false);
    });

    test('Provided password should be a valid password.',() {
      expect(Validator.isValidPassword("ThisisVerysecure112"), false);
    });

    test('Provided password should be a valid password.',() {
      expect(Validator.isValidPassword("jjdoe@bsu!44"), true);
    });
  });
}