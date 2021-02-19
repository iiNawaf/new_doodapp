import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/community.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CommunityProvider with ChangeNotifier {
    DocumentReference docRef;
  final communityCollection = FirebaseFirestore.instance.collection('communities');
  final communityChatCollection = FirebaseFirestore.instance.collection('community_chat');
  List<Community> communityList = [];
  List<CommunityMember> communityMembers = [];
  Community community;
  CommunityMember communityMember;

  Future<void> fetchCommunityList() async {
    QuerySnapshot snapshot = await communityCollection.get();
    List<DocumentSnapshot> result = snapshot.docs;
    communityList = [];
    result.forEach((snap) {
      community = Community(
        id: snap.data()['id'],
        title: snap.data()['title'],
        image: snap.data()['image'],
        bio: snap.data()['bio'],
        ownerID: snap.data()['owner_id'],
      );
      communityList.add(community);
    });
    notifyListeners();
  }

  Future<void> createCommunity(String title, String bio, String ownerID, File image, String username, String email, String profileImage) async {
    docRef = communityCollection.doc();
    String imgUrl;
    Reference reference =
        FirebaseStorage.instance.ref().child('communityImages/${docRef.id}');
    await reference.putFile(image).whenComplete(() async {
      await reference.getDownloadURL().then((value) {
        imgUrl = value;
      });
    });

    await docRef.set({
          'id': docRef.id,
          'title': title,
          'bio': bio,
          'owner_id': ownerID,
          'image': imgUrl == ""
              ? "https://firebasestorage.googleapis.com/v0/b/doodapp-ebf46.appspot.com/o/default_community_image.jpg?alt=media&token=3cd34fb7-e2d6-47ec-81fc-1c2041c6ef46"
              : imgUrl
        })
        .then((value) => print("Done"))
        .catchError((error) => print("Failed to create community!"));
  }

  Future<void> sendMessageToCommunity(
      String senderID, String communityID, String content, String sender) async {
    docRef = communityChatCollection.doc();
    await docRef.set({
      'id': docRef.id,
      'sender_id': senderID,
      'sender': sender,
      'community_id': communityID,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // List of chat community
  List<CommunityChat> _communityChatList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return CommunityChat(
        communityID: doc.data()['community_id'],
        senderID: doc.data()['sender_id'],
        content: doc.data()['content'],
        sender: doc.data()['sender'],
        timestamp: doc.data()['timestamp'],
      );
    }).toList();
  }

// get a stream of chat communities
  Stream<List<CommunityChat>> get loadChatList => communityChatCollection
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map(_communityChatList);


    bool isMemberJoined(String uid) {
    if (communityMembers.isEmpty) {
      return false;
    } else {
      final memberIndex = communityMembers.indexWhere((member) => member.uid == uid);
      return memberIndex == -1 ? false : true;
    }
  }

  Future<void> deleteCommunity(String communityID) async{
    await communityCollection.doc(communityID).delete();
  }
}
