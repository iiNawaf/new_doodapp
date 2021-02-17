import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/community.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CommunityProvider with ChangeNotifier {
  final communityCollection =
      FirebaseFirestore.instance.collection('communities');
  final communityChatCollection =
      FirebaseFirestore.instance.collection('community_chat');
  DocumentReference docRef;
  List<Community> communityList = [];
  Community community;

  Future<List<Community>> fetchCommunityList() async {
    QuerySnapshot snapshot = await communityCollection.get();
    List<DocumentSnapshot> result = snapshot.docs;
    result.forEach((snap) {
      community = Community(
        id: snap.data()['id'],
        title: snap.data()['title'],
        image: snap.data()['image'],
        bio: snap.data()['bio'],
        ownerID: snap.data()['owner_id'],
        totalMembers: snap.data()['total_members'],
      );
      communityList.add(community);
    });
  }

  Future<void> createCommunity(
      String title, String bio, String ownerID, File image) async {
    docRef = communityCollection.doc();
    String imgUrl;
    Reference reference =
        FirebaseStorage.instance.ref().child('communityImages/${docRef.id}');
    await reference.putFile(image).whenComplete(() async {
      await reference.getDownloadURL().then((value) {
        imgUrl = value;
      });
    });

    await docRef
        .set({
          'id': docRef.id,
          'title': title,
          'bio': bio,
          'owner_id': ownerID,
          'total_members': 1,
          'image': imgUrl == ""
              ? "https://firebasestorage.googleapis.com/v0/b/doodapp-ebf46.appspot.com/o/default_community_image.jpg?alt=media&token=3cd34fb7-e2d6-47ec-81fc-1c2041c6ef46"
              : imgUrl
        })
        .then((value) => print("Community created!"))
        .catchError((error) => print("Failed to create community!"));
  }

  Future<void> sendMessageToCommunity(String senderID, String communityID, String content) async {
    docRef = communityChatCollection.doc();
    await docRef.set({
      'id': docRef.id,
      'sender_id': senderID,
      'community_id': communityID,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
 

  // List<CommunityChat> _loadCommunityChat(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((snap) {
  //     return CommunityChat(
  //       senderID: snap.data()['sender_id'],
  //       communityID: snap.data()['community_id'],
  //       content: snap.data()['content'],
  //       timestamp: snap.data()['timestamp'],
  //     );
  //   }).toList();
  // }
 
}
