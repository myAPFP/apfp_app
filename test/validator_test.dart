import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apfp/util/validator/validator.dart';

void main() {
  group("Validator Class - Name Testing", () {
    test('1. Provided name should be a valid name.', () {
      expect(Validator.isValidName("Brandon"), true);
    });

    test('2. Provided name should be a valid name.', () {
      expect(Validator.isValidName("Wilkins"), true);
    });

    test('3. Provided name should be a valid name.', () {
      expect(Validator.isValidName("Joe"), true);
    });

    test('4. Provided name should be a valid name.', () {
      expect(Validator.isValidName("Anthon65y"), false);
    });

    test('5. Provided name should be a valid name.', () {
      expect(Validator.isValidName("Bra 7"), false);
    });

    test('6. Provided name should be a valid name.', () {
      expect(Validator.isValidName("wilkin;"), false);
    });
  });

  group("Validator Class - Email Testing", () {
    test('1. Provided email address should be a valid email address.', () {
      expect(Validator.isValidEmail("jjdoe@bsu.edu"), true);
    });

    test('2. Provided email address should be a valid email address.', () {
      expect(Validator.isValidEmail("janedoe343@gmail.com"), true);
    });

    test('3. Provided email address should be a valid email address.', () {
      expect(Validator.isValidEmail("CappyStone495@cappy.!cap"), false);
    });

    test('4. Provided email address should be a valid email address.', () {
      expect(Validator.isValidEmail("MrSirMan44@a.5.S?"), false);
    });
  });

  group("Validator Class - Password Testing", () {
    test('1. Provided password should be a valid password.', () {
      expect(Validator.isValidPassword("!password99!"), true);
    });

    test('2. Provided password should be a valid password.', () {
      expect(Validator.isValidPassword("p"), false);
    });

    test('3. Provided password should be a valid password.', () {
      expect(Validator.isValidPassword("ThisisVerysecure112"), false);
    });

    test('4. Provided password should be a valid password.', () {
      expect(Validator.isValidPassword("jjdoe@bsu!44"), true);
    });
  });

  group("Validator Class - Profanity Testing", () {
    test('1. Should return true if input contains profanity.', () {
      expect(Validator.hasProfanity("Goofy Ass"), true);
    });

    test('2. Should return true if input contains profanity.', () {
      expect(Validator.hasProfanity("damn"), false);
    });

    test('3. Should return true if input contains profanity.', () {
      expect(Validator.hasProfanity("that's tough."), false);
    });
  });

  group("Validator Class - Activity Name Testing", () {
    test('1. Should return true if input is a valid activity name.', () {
      expect(Validator.isValidActivityName("!Bye, World!"), false);
    });

    test('2. Should return true if input is a valid activity name.', () {
      expect(Validator.isValidActivityName("Ran Twice7"), false);
    });

    test('3. Should return true if input is a valid activity name.', () {
      expect(Validator.isValidActivityName("Jogging"), true);
    });

    test('4. Should return true if input is a valid activity name.', () {
      expect(Validator.isValidActivityName("Walking"), true);
    });
  });

  group("Validator Class - Positive Integer Testing", () {
    test(
        '1. Should return true if input string can be parsed into a integer >= 1',
        () {
      expect(Validator.isPositiveInt("-1"), false);
    });

    test(
        '2. Should return true if input string can be parsed into a integer >= 1',
        () {
      expect(Validator.isPositiveInt("0.1"), false);
    });

    test(
        '3. Should return true if input string can be parsed into a integer >= 1',
        () {
      expect(Validator.isPositiveInt("1"), true);
    });

    test(
        '4. Should return true if input string can be parsed into a integer >= 1',
        () {
      expect(Validator.isPositiveInt("15"), true);
    });
  });

  group("Validator Class - Numeric Testing", () {
    test(
        '1. Should return true if input string can be parsed into a positive number.',
        () {
      expect(Validator.isPositiveNumber("-1"), false);
    });

    test(
        '2. Should return true if input string can be parsed into a positive number.',
        () {
      expect(Validator.isPositiveNumber("-0.1"), false);
    });

    test(
        '3. Should return true if input string can be parsed into a positive number.',
        () {
      expect(Validator.isPositiveNumber("25"), true);
    });

    test(
        '4. Should return true if input string can be parsed into a positive number.',
        () {
      expect(Validator.isPositiveNumber("15.5"), true);
    });
  });

  group("Validator Class - TextField Testing", () {
    var tc = TextEditingController();
    test('1. Should return true if the textField has a value.', () {
      tc.clear();
      tc.text = "123";
      expect(Validator.textFieldHasValue(tc), true);
    });

    test('2. Should return true if the textField has a value.', () {
      tc.clear();
      tc.text = " ";
      expect(Validator.textFieldHasValue(tc), true);
    });

    test('3. Should return true if the textField has a value.', () {
      tc.clear();
      tc.text = "";
      expect(Validator.textFieldHasValue(tc), false);
    });

    test('4. Should return true if the textField has a value.', () {
      tc.clear();
      expect(Validator.textFieldHasValue(tc), false);
    });
  });
}
