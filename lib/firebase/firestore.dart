import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apfp/firebase/fire_auth.dart';

class FireStore {
  static Future<QuerySnapshot> getPlaylistID() {
    return FirebaseFirestore.instance.collection('youtube playlist ids').get();
  }

  static Future<QuerySnapshot> getVideoCount() {
    return FirebaseFirestore.instance.collection('total video count').get();
  }

  static void setVideoCount(int vidCount) {
    var collection = FirebaseFirestore.instance.collection('total video count');
    collection
        .doc('vidCount')
        .update({'vidCount': vidCount})
        .catchError((error) => FireAuth.showToast('Failed: $error'));
  }

  static Future<QuerySnapshot> getAnnouncements() {
    return FirebaseFirestore.instance
        .collection('announcements')
        .orderBy("id", descending: true)
        .get();
  }
}
