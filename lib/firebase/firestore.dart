import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStore {
  static Stream<QuerySnapshot> getYTPlaylistIDs() {
    return FirebaseFirestore.instance
        .collection('youtube-playlists')
        .snapshots();
  }

  static Stream<QuerySnapshot> getYTVideoUrls() {
    return FirebaseFirestore.instance
        .collection('youtube-videos')
        .orderBy("id", descending: true)
        .snapshots();
  }

  static void storeUID(String docId, String uid) {
    FirebaseFirestore.instance
        .collection('registered-users')
        .doc(docId)
        .update({"UID": uid});
  }

  static Future<QuerySnapshot> getRegisteredUser(String email) {
    return FirebaseFirestore.instance
        .collection('registered-users')
        .where('email', isEqualTo: email)
        .get();
  }

  static Future<QuerySnapshot> getAdminEmails() async {
    return FirebaseFirestore.instance.collection('admins').get();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAnnouncements(
      {int limit = 20}) {
    return FirebaseFirestore.instance
        .collection('announcements')
        .orderBy("id", descending: true)
        .limit(limit)
        .snapshots();
  }

  static DocumentReference<Map<String, dynamic>> getUserActivityDocument() {
    return FirebaseFirestore.instance
        .collection('activity')
        .doc(FirebaseAuth.instance.currentUser!.email.toString());
  }

  static CollectionReference<Map<String, dynamic>> getGoalLogCollection(
      {required String goalType}) {
    return FirebaseFirestore.instance
        .collection('goal-logs')
        .doc(goalType)
        .collection(FirebaseAuth.instance.currentUser!.email.toString());
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>>
      createUserActivityStream() {
    return getUserActivityDocument().snapshots();
  }

  static Future<void> updateWorkoutData(Map<String, dynamic> data) {
    return getUserActivityDocument().set(data);
  }

  static void createUserActivityDocument() async {
    await FirebaseFirestore.instance
        .collection('activity')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set(new Map());
  }

  static DocumentReference<Map<String, dynamic>> getHealthDocument() {
    return FirebaseFirestore.instance
        .collection('health')
        .doc(FirebaseAuth.instance.currentUser!.email.toString());
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>>
      createHealthDocStream() {
    return getHealthDocument().snapshots();
  }

  static Future<void> updateHealthData(Map<String, dynamic> data) {
    return getHealthDocument().update(data);
  }

  static void createHealthDocument() async {
    await FirebaseFirestore.instance
        .collection('health')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set({
      "isHealthTrackerPermissionGranted": false,
      "isDailyDisplayed": true,
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
      "exerciseTimeGoalProgressWeekly": 0,
      "exerciseTimeGoalProgress": 0,
      "exerciseTimeEndGoal": 0,
      "exerciseTimeEndGoal_w": 0,
      "calGoalProgress": 0,
      "calGoalProgressWeekly" : 0,
      "calEndGoal": 0,
      "calEndGoal_w": 0,
      "stepGoalProgress": 0,
      "stepGoalProgressWeekly": 0,
      "stepEndGoal": 0,
      "stepEndGoal, w": 0,
      "mileGoalProgress": 0,
      "mileGoalProgressWeekly": 0,
      "mileEndGoal": 0,
      "mileEndGoal_w": 0,
      "cyclingGoalProgress": 0,
      "cyclingGoalProgressWeekly": 0,
      "cyclingEndGoal": 0,
      "cyclingWeeklyEndGoal": 0,
      "rowingGoalProgress": 0,
      "rowingGoalProgressWeekly": 0,
      "rowingEndGoal": 0,
      "rowingWeeklyEndGoal": 0,
      "stepMillGoalProgress": 0,
      "stepMillGoalProgressWeekly": 0,
      "stepMillEndGoal": 0,
      "stepMillWeeklyEndGoal": 0,
      "exerciseWeekDeadline": "0/00/0000",
      "calWeekDeadline": "0/00/0000",
      "stepWeekDeadline": "0/00/0000",
      "mileWeekDeadline": "0/00/0000",
      "cyclingWeekDeadline": "0/00/0000",
      "rowingWeekDeadline": "0/00/0000",
      "stepMillWeekDeadline": "0/00/0000",
      "dayOfMonth": DateTime.now().day
    });
  }
}
