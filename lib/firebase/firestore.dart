import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStore {
  static Stream<QuerySnapshot> getYTPlaylistIDs() {
    return FirebaseFirestore.instance
        .collection('youtube-playlists')
        .orderBy("Title")
        .snapshots();
  }

  static Stream<QuerySnapshot> getYTVideoUrls() {
    return FirebaseFirestore.instance
        .collection('youtube-videos')
        .orderBy("Title")
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

  static DocumentReference<Map<String, dynamic>>
      getUserActivityTrackerDocument() {
    return FirebaseFirestore.instance
        .collection('health')
        .doc(FirebaseAuth.instance.currentUser!.email.toString());
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>>
      createUserActivityTrackerStream() {
    return getUserActivityTrackerDocument().snapshots();
  }

  static Future<void> updateHealthData(Map<String, dynamic> data) {
    return getUserActivityTrackerDocument().update(data);
  }

  static void createHealthDocument() async {
    await FirebaseFirestore.instance
        .collection('health')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set({
      "isHealthTrackerPermissionGranted": false,
      "isExerciseTimeGoalSet": false,
      "isCalGoalSet": false,
      "isStepGoalSet": false,
      "isMileGoalSet": false,
      // ! Change these default values to
      // ! 0 once 'Add Goal' screen is implemented
      // ! Some are set to 10 to avoid 0/0 = NaN issues
      "userProgressExerciseTime": 0,
      "userSetExerciseTimeGoal": 10,
      "userProgressCalGoal": 0,
      "userSetCalGoal": 10,
      "userProgressStepGoal": 0,
      "userSetStepGoal": 10,
      "userProgressMileGoal": 0,
      "userSetMileGoal": 10
    });
  }

  static Map<String, dynamic> healthPermissionToMap(bool permission) {
    return {
      "isHealthTrackerPermissionGranted": permission,
    };
  }

  static Map<String, dynamic> exerciseGoalBoolToMap(bool isExerciseGoalSet) {
    return {
      "isExerciseTimeGoalSet": isExerciseGoalSet,
    };
  }

  static Map<String, dynamic> calGoalBoolToMap(bool isCalGoalSet) {
    return {
      "isCalGoalSet": isCalGoalSet,
    };
  }

  static Map<String, dynamic> stepGoalBoolToMap(bool isStepGoalSet) {
    return {
      "isStepGoalSet": isStepGoalSet,
    };
  }

  static Map<String, dynamic> mileGoalBoolToMap(bool isMileGoalSet) {
    return {
      "isMileGoalSet": isMileGoalSet,
    };
  }

  static Map<String, dynamic> mileProgressToMap(double mileProgress) {
    return {
      "userProgressMileGoal": mileProgress,
    };
  }

  static Map<String, dynamic> mileSetToMap(double miles) {
    return {
      "userSetMileGoal": miles,
    };
  }

  static Map<String, dynamic> stepProgressToMap(double stepProgress) {
    return {
      "userProgressStepGoal": stepProgress,
    };
  }

  static Map<String, dynamic> stepSetToMap(double stepCount) {
    return {
      "userSetStepGoal": stepCount,
    };
  }

  static Map<String, dynamic> calProgressToMap(double calProgress) {
    return {
      "userProgressCalGoal": calProgress,
    };
  }

  static Map<String, dynamic> calSetToMap(double calsBurned) {
    return {
      "userSetCalGoal": calsBurned,
    };
  }

  static Map<String, dynamic> exerciseTimeProgressToMap(double exerciseTimeProgress) {
    return {
      "userProgressExerciseTime": exerciseTimeProgress,
    };
  }

  static Map<String, dynamic> exerciseTimeSetToMap(double minutes) {
    return {
      "userSetExerciseTimeGoal": minutes,
    };
  }
}
