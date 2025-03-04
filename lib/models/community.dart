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
  String? lastMessage;
  String? status;

  Community({
    required this.id,
    required this.bio,
    required this.title,
    required this.image,
    required this.ownerID,
    this.status,
    this.lastMessage,
    required this.ownerProfileImg,
    required this.ownerUsername,
    required this.categoryImage,
    required this.categoryTitle,
    this.createTime,
  });
}

class CommunityChat {
  final String senderID;
  final String communityID;
  String? content;
  String? sender;
  Timestamp? timestamp;

  CommunityChat({
    required this.senderID,
    required this.communityID,
    this.content,
    this.sender,
    this.timestamp,
  });
}

class CommunityMember {
  final String uid;
  final String username;
  final String email;
  String? profileImage;

  CommunityMember({
    required this.uid,
    required this.email,
    required this.username,
    this.profileImage,
  });
}

class RecentCommunity {
  final String id;
  final String uid;
  final String title;
  final String bio;
  final String image;
  final dynamic timeStamp;
  RecentCommunity({
    required this.id,
    required this.title,
    required this.bio,
    required this.image,
    required this.uid,
    required this.timeStamp,
  });
}
