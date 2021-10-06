import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/category.dart';
import 'package:doodapp/models/community.dart';
import 'package:doodapp/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CommunityProvider with ChangeNotifier {
  DocumentReference communityRef;
  final communityCollection =
      FirebaseFirestore.instance.collection('communities');
  final communityChatCollection =
      FirebaseFirestore.instance.collection('community_chat');
  final userCollection = FirebaseFirestore.instance.collection('users_info');
  final categoryCollection =
      FirebaseFirestore.instance.collection('categories');

  List<Community> communityList = [];
  Community community;
  UserModel currentUser;

  Future<void> fetchCommunityList() async {
    try {
      QuerySnapshot snapshot = await communityCollection
          .orderBy('create_time', descending: true)
          .get();
      List<DocumentSnapshot> result = snapshot.docs;
      communityList = [];
      result.forEach((snap) {
        community = Community(
          id: snap.data()['id'],
          title: snap.data()['title'],
          image: snap.data()['image'],
          bio: snap.data()['bio'],
          ownerID: snap.data()['owner_id'],
          status: snap.data()['status'],
          lastMessage: snap.data()['last_message'],
          ownerUsername: snap.data()['owner_username'],
          ownerProfileImg: snap.data()['owner_profile_img'],
          categoryTitle: snap.data()['category_title'],
          categoryImage: snap.data()['category_image'],
          createTime: snap.data()['create_time'],
        );
        communityList.add(community);
      });
      notifyListeners();
    } catch (e) {
      print("Error $e");
    }
  }

  Future<void> createCommunity(
      String title,
      String bio,
      String ownerID,
      File image,
      String username,
      String email,
      String profileImage,
      Category category) async {
    communityRef = communityCollection.doc();
    String imgUrl;
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('communityImages/${communityRef.id}');
    await reference.putFile(image).whenComplete(() async {
      await reference.getDownloadURL().then((value) {
        imgUrl = value;
      });
    });

    await communityRef
        .set({
          'id': communityRef.id,
          'title': title,
          'bio': bio,
          'owner_id': ownerID,
          'owner_username': username,
          'owner_profile_img': profileImage,
          'image': imgUrl == ""
              ? "https://firebasestorage.googleapis.com/v0/b/doodapp-ebf46.appspot.com/o/default_community_image.jpg?alt=media&token=3cd34fb7-e2d6-47ec-81fc-1c2041c6ef46"
              : imgUrl,
          'status': "available",
          'last_message': "",
          'category_title': category.title,
          'category_image': category.image,
          'create_time': FieldValue.serverTimestamp()
        })
        .then((value) => print("Done"))
        .catchError((error) => print("Failed to create community!"));
  }

  Future<void> sendMessageToCommunity(
      String senderID,
      String communityID,
      String content,
      String sender,
      String communityTitle,
      String communityImage,
      String communityBio) async {
    communityRef = communityChatCollection.doc();
    await communityRef.set({
      'id': communityRef.id,
      'sender_id': senderID,
      'sender': sender,
      'community_id': communityID,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });

    //update last message in community
    await communityCollection
        .doc(communityID)
        .update({'last_message': content});

    // add community to user joined communities
    await userCollection.doc(senderID).update({
      'communities_joined': FieldValue.arrayUnion([communityID]),
    });
  }

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

  Future<void> deleteCommunity(String communityID) async {
    await communityCollection.doc(communityID).delete().then((e) {
      fetchCommunityList();
    });
  }
}
