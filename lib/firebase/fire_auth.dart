import 'package:apfp/util/toasted/toasted.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FireAuth {
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

  static Future<User?> signInUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
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

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await user.reload();
    User? refreshedUser = auth.currentUser;
    return refreshedUser;
  }

  static sendEMmailNotification(User? user) async {
    if (user != null) {
      await user.sendEmailVerification();
    }
  }

  static reSendEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      refreshUser(user);
      if (!user.emailVerified) {
        sendEMmailNotification(user);
        Toasted.showToast("A new verification email has been sent.");
      }
    } else
      Toasted.showToast("You must attempt to login first.");
  }

  static signOut() async {
    await FirebaseAuth.instance.signOut();
    Toasted.showToast("Signed out.");
  }

  static deleteCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('registered users')
          .doc(user.uid)
          .delete()
          .whenComplete(() {
        FirebaseAuth.instance.currentUser?.delete().whenComplete(() {
          // Closes app
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        });
      });
    }
  }

  static updateEmail({required String newEmail}) {
    User? user = FirebaseAuth.instance.currentUser;
    user!
        .updateEmail(newEmail)
        .then((value) => Toasted.showToast("Email has been updated."));
  }

  static sendResetPasswordLink({required String email}) async {
    final auth = FirebaseAuth.instance;
    await auth
        .sendPasswordResetEmail(email: email)
        .whenComplete(
            () => Toasted.showToast("Please check your email to reset your password."))
        .catchError((e) => Toasted.showToast(e.toString()));
  }

  
}
