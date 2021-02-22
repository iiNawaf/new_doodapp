import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/reports.dart';
import 'package:flutter/material.dart';

class ReportsProvider with ChangeNotifier {
  final communityChatReportsCollection = FirebaseFirestore.instance.collection('community_chat_reports');
  final liveChatReportsCollection = FirebaseFirestore.instance.collection('live_chat_reports');

  Future submitCommunityChatReport(String communityID, String senderID, String senderName, String message) async{
    await communityChatReportsCollection.doc().set({
      'community_id': communityID,
      'sender_id': senderID,
      'sender_username': senderName,
      'content_message': message,
      'report_time': FieldValue.serverTimestamp(),
      'status': "not_solved",
    });
  }

    Future submitLiveChatReport(String senderID, String senderName, String message) async{
    await liveChatReportsCollection.doc().set({
      'sender_id': senderID,
      'sender_username': senderName,
      'content_message': message,
      'report_time' : FieldValue.serverTimestamp(),
      'status': "not_solved",
    });
  }

  Future<void> blockUserFromCommunityChat(String senderID, String docID) async{
    await communityChatReportsCollection.doc(docID).update({
      'status': 'solved'
    });
    await FirebaseFirestore.instance.collection('users').doc(senderID).update({
      'status' : 'blocked'
    });
  }

    Future<void> blockUserFromLiveChat(String senderID, String docID) async{
    await liveChatReportsCollection.doc(docID).update({
      'status': 'solved'
    });
    await FirebaseFirestore.instance.collection('users').doc(senderID).update({
      'status' : 'blocked'
    });
  }
}