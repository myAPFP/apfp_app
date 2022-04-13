// Copyright 2022 The myAPFP Authors. All rights reserved.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  /// Fetches a stream of APFP YouTube playlist ids from Firestore.
  static Stream<QuerySnapshot> getYTPlaylistIDs() {
    return FirebaseFirestore.instance
        .collection('youtube-playlists')
        .snapshots();
  }

  /// Fetches a stream of APFP YouTube video urls from Firestore.
  static Stream<QuerySnapshot> getYTVideoUrls() {
    return FirebaseFirestore.instance.collection('youtube-videos').snapshots();
  }

  /// Stores a user's UID in their associated document in the registered-users
  /// Firestore collection.
  ///
  /// This is to allow an admin to delete a user's account via the admin panel.
  /// In order to delete a user's account, you must have their UID.
  static void storeUID(String docId, String uid) {
    FirebaseFirestore.instance
        .collection('registered-users')
        .doc(docId)
        .update({"UID": uid});
  }

  /// Queries the registered-users Firestore collection. If there is an email
  /// address matching the one being passed in, the user is registered with the
  /// APFP and is permitted access to myAPFP.
  static Future<QuerySnapshot> getRegisteredUser(String email) {
    return FirebaseFirestore.instance
        .collection('registered-users')
        .where('email', isEqualTo: email)
        .get();
  }

  /// Fetches admin emails stored in Firestore.
  static Future<QuerySnapshot> getAdminEmails() async {
    return FirebaseFirestore.instance.collection('admins').get();
  }

  /// Fetches announcements stored in Firestore.
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAnnouncements(
      {int limit = 20}) {
    return FirebaseFirestore.instance
        .collection('announcements')
        .orderBy("id", descending: true)
        .limit(limit)
        .snapshots();
  }

  /// Fetches the user's activity document in Firestore.
  static DocumentReference<Map<String, dynamic>> getUserActivityDocument() {
    return FirebaseFirestore.instance
        .collection('activity')
        .doc(FirebaseAuth.instance.currentUser!.email.toString());
  }

  /// Fetches the user's goal log collection in Firestore.
  static CollectionReference<Map<String, dynamic>> getGoalLogCollection(
      {required String goalType}) {
    return FirebaseFirestore.instance
        .collection('goal-logs')
        .doc(goalType)
        .collection(FirebaseAuth.instance.currentUser!.email.toString());
  }

  /// Creates stream that listens to the user's activity document in Firestore.
  static Stream<DocumentSnapshot<Map<String, dynamic>>>
      createUserActivityStream() {
    return getUserActivityDocument().snapshots();
  }

  /// Updates a user's activity document.
  ///
  /// The [data] is a map where the String key values serves as field names
  /// and any value (dynamic) serves as the field's value.
  static Future<void> updateWorkoutData(Map<String, dynamic> data) {
    return getUserActivityDocument().set(data);
  }

  /// Creates a user's activity document in Firestore.
  static void createUserActivityDocument() async {
    await FirebaseFirestore.instance
        .collection('activity')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set(new Map());
  }

  /// Fetches the user's goal document in Firestore.
  static DocumentReference<Map<String, dynamic>> getGoalDocument() {
    return FirebaseFirestore.instance
        .collection('goals')
        .doc(FirebaseAuth.instance.currentUser!.email.toString());
  }

  /// Creates stream that listens to the user's goal document in Firestore.
  static Stream<DocumentSnapshot<Map<String, dynamic>>> createGoalDocStream() {
    return getGoalDocument().snapshots();
  }

  /// Updates a user's goal document.
  ///
  /// The [data] is a map where the String key values serves as field names
  /// and any value (dynamic) serves as the field's value.
  static Future<void> updateGoalData(Map<String, dynamic> data) {
    return getGoalDocument().update(data);
  }

  /// Creates a user's goal document in Firestore.
  ///
  /// The document has all fields set with default field names and values.
  static void createGoalDocument() async {
    await FirebaseFirestore.instance
        .collection('goals')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set({
      "isHealthAppSynced": false,
      "isDailyGoalsDisplayed": true,
      "isExerciseTimeGoalSet": false,
      "isExerciseTimeGoalSet_w": false,
      "isCalGoalSet": false,
      "isCalGoalSet_w": false,
      "isStepGoalSet": false,
      "isStepGoalSet_w": false,
      "isMileGoalSet": false,
      "isMileGoalSet_w": false,
      "isCyclingGoalSet": false,
      'isCyclingGoalSet_w': false,
      "isRowingGoalSet": false,
      "isRowingGoalSet_w": false,
      "isStepMillGoalSet": false,
      "isStepMillGoalSet_w": false,
      "isEllipticalGoalSet": false,
      "isEllipticalGoalSet_w": false,
      "isResistanceStrengthGoalSet": false,
      "isResistanceStrengthGoalSet_w": false,
      "exerciseTimeGoalProgressWeekly": 0,
      "exerciseTimeGoalProgress": 0,
      "exerciseTimeEndGoal": 0,
      "exerciseTimeEndGoal_w": 0,
      "calGoalProgress": 0,
      "calGoalProgressWeekly": 0,
      "calEndGoal": 0,
      "calEndGoal_w": 0,
      "stepGoalProgress": 0,
      "stepGoalProgressWeekly": 0,
      "stepEndGoal": 0,
      "stepEndGoal_w": 0,
      "mileGoalProgress": 0,
      "mileGoalProgressWeekly": 0,
      "mileEndGoal": 0,
      "mileEndGoal_w": 0,
      "cyclingGoalProgress": 0,
      "cyclingGoalProgressWeekly": 0,
      "cyclingEndGoal": 0,
      "cyclingEndGoal_w": 0,
      "rowingGoalProgress": 0,
      "rowingGoalProgressWeekly": 0,
      "rowingEndGoal": 0,
      "rowingEndGoal_w": 0,
      "stepMillGoalProgress": 0,
      "stepMillGoalProgressWeekly": 0,
      "stepMillEndGoal": 0,
      "stepMillEndGoal_w": 0,
      "ellipticalGoalProgress": 0,
      "ellipticalGoalProgressWeekly": 0,
      "ellipticalEndGoal": 0,
      "ellipticalEndGoal_w": 0,
      "resistanceStrengthGoalProgress": 0,
      "resistanceStrengthGoalProgressWeekly": 0,
      "resistanceStrengthEndGoal": 0,
      "resistanceStrengthEndGoal_w": 0,
      "exerciseWeekDeadline": "0/00/0000",
      "calWeekDeadline": "0/00/0000",
      "stepWeekDeadline": "0/00/0000",
      "mileWeekDeadline": "0/00/0000",
      "cyclingWeekDeadline": "0/00/0000",
      "rowingWeekDeadline": "0/00/0000",
      "stepMillWeekDeadline": "0/00/0000",
      "ellipticalWeekDeadline": "0/00/0000",
      "resistanceStrengthWeekDeadline": "0/00/0000",
      "dayOfMonth": DateTime.now().day
    });
  }
}
