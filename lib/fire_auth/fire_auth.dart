import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireAuth {
  static const REGISTERED_USERS = 'registered users';
  static const YT_PLAYLIST_IDS = 'youtube playlist ids';

  Future<User?> registerUsingEmailPassword(
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
          showToast('An account already exists with this email.');
          break;
      }
    }
    return user;
  }

  Future<User?> signInUsingEmailPassword(
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
        case 'user-disabled':
          showToast('Account is disabled. Please contact the admin.');
          break;
      }
    }
    return user;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRegisteredUser(String email) {
    showToast("Verifying Membership...");
    return FirebaseFirestore.instance
        .collection(REGISTERED_USERS)
        .where('email', isEqualTo: email)
        .get();
  }

  Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await user.reload();
    User? refreshedUser = auth.currentUser;
    return refreshedUser;
  }

  sendEMmailNotification(User? user) async {
    if (user != null) {
      await user.sendEmailVerification();
    }
  }

  reSendEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      refreshUser(user);
      if (!user.emailVerified) {
        sendEMmailNotification(user);
      }
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    showToast("Signed out.");
  }

  deleteCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection(REGISTERED_USERS)
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

  resetPassword({required String email, required Function onError}) async {
    final auth = FirebaseAuth.instance;
    await auth
        .sendPasswordResetEmail(email: email)
        .whenComplete(
            () => showToast("Please check your email to reset your password."))
        .catchError(onError);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPlaylistID() {
    return FirebaseFirestore.instance.collection(YT_PLAYLIST_IDS).get();
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
  }
}
