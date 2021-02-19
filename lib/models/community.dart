import 'package:cloud_firestore/cloud_firestore.dart';

class Community {
  final String id;
  final String title;
  final String bio;
  final String image;
  final String ownerID;

  Community({this.id, this.bio, this.title, this.image, this.ownerID});
}


class CommunityChat {
  final String senderID;
  final String communityID;
  String content;
  String sender;
  Timestamp timestamp;

  CommunityChat({this.senderID, this.communityID, this.content, this.sender, this.timestamp});
}


class CommunityMember{
  final String uid;
  final String username;
  final String email;
  String profileImage;


  CommunityMember({this.uid, this.email, this.username, this.profileImage});
}