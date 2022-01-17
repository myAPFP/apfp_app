import 'package:flutter_test/flutter_test.dart';
import 'package:apfp/util/validator/validator.dart';
void main() {
  final verify = Validator();
  group("User Verification Testing", () {

    // Name ------------------------------------------------------

    test('Provided name should be a valid name.',() {
      expect(verify.isValidName("Brandon"), true);
    });

    test('Provided name should be a valid name.', () {
      expect(verify.isValidName("Wilkins"), true);
    });

    test('Provided name should be a valid name.',() {
      expect(verify.isValidName("Joe"), true);
    });
    
    test('Provided name should be a valid name.', () {
      expect(verify.isValidName("Anthon65y"), false);
    });

    test('Provided name should be a valid name.',() {
      expect(verify.isValidName("Bra 7"), false);
    });

    test('Provided name should be a valid name.', () {
      expect(verify.isValidName("wilkin;"), false);
    });

    // Phone ------------------------------------------------------

    test('Provided phone number should be a valid phone number.',() {
      expect(verify.isValidPhone("6542125359"), false);
    });

    test('Provided phone number should be a valid phone number.',() {
      expect(verify.isValidPhone("(334) 565-3222"), false);
    });

    test('Provided phone number should be a valid phone number.',() {
      expect(verify.isValidPhone("897-123-2432"), true);
    });

    test('Provided phone number should be a valid phone number.',() {
      expect(verify.isValidPhone("433-643-7643"), true);
    });

    // Email ------------------------------------------------------

    test('Provided email address should be a valid email address.',() {
      expect(verify.isValidEmail("jjdoe@bsu.edu"), true);
    });

    test('Provided email address should be a valid email address.',() {
      expect(verify.isValidEmail("janedoe343@gmail.com"), true);
    });

    test('Provided email address should be a valid email address.',() {
      expect(verify.isValidEmail("CappyStone495@cappy.!cap"), false);
    });

    test('Provided email address should be a valid email address.',() {
      expect(verify.isValidEmail("MrSirMan44@a.5.S?"), false);
    });

    // Password ------------------------------------------------------

    test('Provided password should be a valid password.',() {
      expect(verify.isValidPassword("!password99!"), true);
    });

    test('Provided password should be a valid password.',() {
      expect(verify.isValidPassword("p"), false);
    });

    test('Provided password should be a valid password.',() {
      expect(verify.isValidPassword("ThisisVerysecure112"), false);
    });

    test('Provided password should be a valid password.',() {
      expect(verify.isValidPassword("jjdoe@bsu!44"), true);
    });
  });
}