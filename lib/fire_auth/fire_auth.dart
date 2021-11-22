import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireAuth {
  static const COLLECTION_NAME = 'registered users';

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
          showToast('The password provided is too weak.');
          break;
        case 'email-already-in-use':
          showToast('The account already exists for that email.');
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
          showToast('No user found for that email.');
          break;
        case 'wrong-password':
          showToast('Wrong password provided.');
          break;
      }
    }
    return user;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRegisteredUser(String email) {
    FireAuth.showToast("Verifying User...");
    return FirebaseFirestore.instance
        .collection(FireAuth.COLLECTION_NAME)
        .where('email', isEqualTo: email)
        .get();
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
      }
    }
  }

  static signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static deleteCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection(COLLECTION_NAME)
          .doc(user.uid)
          .delete()
          .whenComplete(() {
        showToast("Deleting Account..");
        FirebaseAuth.instance.currentUser?.delete().whenComplete(() {
          showToast("Account has been deleted.");
        });
      });
    }
  }

  static void resetPassword(
      {required String email, required Function onError}) async {
    final auth = FirebaseAuth.instance;
    await auth
        .sendPasswordResetEmail(email: email)
        .whenComplete(
            () => showToast("Please check your email to reset your password."))
        .catchError(onError);
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }
}