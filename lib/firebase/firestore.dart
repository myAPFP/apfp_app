import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  static const YT_PLAYLIST_IDS = 'youtube playlist ids';

  Future<QuerySnapshot<Map<String, dynamic>>> getPlaylistID() {
    return FirebaseFirestore.instance.collection(YT_PLAYLIST_IDS).get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAnnouncements(
      {int limit = 20}) {
    return FirebaseFirestore.instance
        .collection('announcements')
        .orderBy("id", descending: true)
        .limit(limit)
        .snapshots();
  }
}
