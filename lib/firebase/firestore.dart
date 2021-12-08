import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  static const YT_PLAYLIST_IDS = 'youtube playlist ids';

  Future<QuerySnapshot<Map<String, dynamic>>> getPlaylistID() {
    return FirebaseFirestore.instance.collection(YT_PLAYLIST_IDS).get();
  }

  Future<QuerySnapshot> getAnnouncements() {
    return FirebaseFirestore.instance.collection('announcements').get();
  }
}
