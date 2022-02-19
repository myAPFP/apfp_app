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

  static Future<void> updateActivityTrackerPermission(
      Map<String, dynamic> data) {
    return getUserActivityTrackerDocument().set(data);
  }

  static void createActivityTrackerDocument() async {
    await FirebaseFirestore.instance
        .collection('health')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set(new Map());
  }

  static Map<String, dynamic> permissionToMap(bool permission) {
    return {
      "healthTrackerPermissionGranted": permission,
    };
  }
}
