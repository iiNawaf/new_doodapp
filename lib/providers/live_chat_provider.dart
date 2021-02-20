import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/live_chat.dart';
import 'package:flutter/material.dart';

class LiveChatProvider with ChangeNotifier {
  final liveChatCollection = FirebaseFirestore.instance.collection('live_chat');
  List<LiveChat> liveChatList;
  LiveChat liveChat;

  Future<void> sendToLiveChat(String message, String senderID,
      String senderUsername, String senderImage, String senderEmail) async {
    await liveChatCollection.doc().set({
      'message': message,
      'sender_id': senderID,
      'sender_username': senderUsername,
      'sender_image': senderImage,
      'sender_email': senderEmail,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  List<LiveChat> _loadLiveChat(QuerySnapshot snapshot) {
    return snapshot.docs.map((docs) {
      return LiveChat(
        message: docs.data()['message'],
        senderID: docs.data()['sender_id'],
        senderUsername: docs.data()['sender_username'],
        senderImage: docs.data()['sender_image'],
        email: docs.data()['sender_email'],
        timestamp: docs.data()['timestamp'],
      );
    }).toList();
  }

  Stream<List<LiveChat>> get loadLiveChat =>
      liveChatCollection.orderBy('timestamp', descending: true).snapshots().map(_loadLiveChat);
}
