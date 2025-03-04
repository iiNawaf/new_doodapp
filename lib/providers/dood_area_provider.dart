import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/dood.dart';
import 'package:flutter/material.dart';

class DoodAreaProvider extends ChangeNotifier {
  final doodCollection = FirebaseFirestore.instance.collection("dood_area");
  Dood? dood;
  List<Dood> doods = [];

  Future<void> fetchDoods() async {
    try {
      QuerySnapshot snapshot =
          await doodCollection.orderBy("send_time", descending: true).get();
      List<DocumentSnapshot> result = snapshot.docs;
      doods = [];

      for (var snap in result) {
        var data = snap.data();
        if (data != null && data is Map<String, dynamic>) {
          dood = Dood(
            id: data['id'] ?? '', // Default empty string
            senderID: data['sender_id'] ?? '',
            content: data['content'] ?? '',
            sendTime: data['send_time'] ?? Timestamp.now(), // Default timestamp
            isReported: data['is_reported'] ?? false, // Default false
          );
          doods.add(dood!);
        }
      }
      notifyListeners();
    } catch (e) {
      print("Error fetching doods: $e");
    }
  }

  Future<void> sendDood(String content, String senderID) async {
    DocumentReference docRef = doodCollection.doc();
    await docRef.set({
      "id": docRef.id,
      "content": content,
      "sender_id": senderID,
      "send_time": FieldValue.serverTimestamp(),
      "is_reported": false
    }).then((value) => fetchDoods());
  }

  Future<void> sendReport(String id) async {
    await doodCollection.doc(id).update({"is_reported": true});
  }

  Future<void> deleteDood(String id) async {
    await doodCollection.doc(id).delete();
  }
}
