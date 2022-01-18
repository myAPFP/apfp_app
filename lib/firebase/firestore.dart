import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  static  String _docID = "";

  static Future<QuerySnapshot> getPlaylistIDs() {
    return FirebaseFirestore.instance
        .collection('youtube playlist ids')
        .orderBy("Title")
        .get();
  }

  static Future<QuerySnapshot> getVideoUrls() {
    return FirebaseFirestore.instance
        .collection('youtube video urls')
        .orderBy("Title")
        .get();
  }

  static void storeUID(String docId, String uid) {
    FirebaseFirestore.instance
        .collection('registered users')
        .doc(docId)
        .update({"UID": uid});
  }

  static String getUserDocID(String email) {
    print(email);
    getRegisteredUser(email).then((querySnapshot) {
      if (querySnapshot.size != 0) {
        _docID = querySnapshot.docs.first.id;
        print("PASS: id is $_docID");
      } else
        print("FAIL");
    });   
    return _docID;
  }

  static Future<QuerySnapshot> getRegisteredUser(String email) {
    return FirebaseFirestore.instance
        .collection('registered users')
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
}
