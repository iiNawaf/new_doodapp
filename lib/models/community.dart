import 'package:cloud_firestore/cloud_firestore.dart';

class Community {
  final String id;
  final String title;
  final String bio;
  final String image;
  final String ownerID;
  final String ownerUsername;
  final String ownerProfileImg;
  final String categoryTitle;
  final String categoryImage;
  final dynamic createTime;
  String lastMessage;
  String status;

  Community({this.id, this.bio, this.title, this.image, this.ownerID, this.status, this.lastMessage, this.ownerProfileImg, this.ownerUsername, this.categoryImage, this.categoryTitle, this.createTime});
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

class RecentCommunity{
  final String id;
  final String uid;
  final String title;
  final String bio;
  final String image;
  final dynamic timeStamp;
  RecentCommunity({this.id, this.title, this.bio, this.image, this.uid, this.timeStamp});
}