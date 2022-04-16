// Copyright 2022 The myAPFP Authors. All rights reserved.

import '/util/toasted/toasted.dart';

import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  /// Registers a user via email and password.
  static Future<User?> registerUsingEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    User? user;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          Toasted.showToast('The password provided is too weak.');
          break;
        case 'email-already-in-use':
          Toasted.showToast('An account already exists with this email.');
          break;
      }
    }
    return user;
  }

  /// Signs in a user via email and password.
  static Future<User?> signInUsingEmailPassword(
      {required String email, required String password}) async {
    User? user;
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          Toasted.showToast('No user found for that email.');
          break;
        case 'wrong-password':
          Toasted.showToast('Wrong password provided.');
          break;
        case 'user-disabled':
          Toasted.showToast('Account is disabled. Please contact the admin.');
          break;
      }
    }
    return user;
  }

  /// Resends a verification email to the user's email address.
  ///
  /// If a user has already verified their email, and toast will be displayed to
  /// inform the user.
  static reSendEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      if (!user.emailVerified) {
        user
            .sendEmailVerification()
            .onError((error, stackTrace) => print(error));
        Toasted.showToast(
            "A new verification email has been sent to: ${user.email}");
      } else
        Toasted.showToast('Your email has already been verified.');
    }
  }

  /// Signs the user out.
  static signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /// Deletes user then closes app.
  static void deleteUserAccount() {
    FirebaseAuth.instance.currentUser?.delete().whenComplete(() {
      Toasted.showToast("Account has been deleted.");
      closeApp();
    });
  }

  /// Closes app.
  static void closeApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  /// Allows a user to update their email address.
  static updateEmail({required String newEmail}) {
    User? user = FirebaseAuth.instance.currentUser;
    user!
        .updateEmail(newEmail)
        .then((value) => Toasted.showToast("Email has been updated."));
  }

  /// Sends a password reset link to the user's email address.
  static sendResetPasswordLink({required String email}) async {
    final auth = FirebaseAuth.instance;
    await auth
        .sendPasswordResetEmail(email: email)
        .whenComplete(() => Toasted.showToast("A link has been sent to $email"))
        .onError((error, stackTrace) => print(error));
  }
}
