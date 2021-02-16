class Community {
  final String id;
  final String title;
  final String bio;
  final String image;
  final String ownerID;
  int totalMembers;

  Community({this.id, this.bio, this.title, this.image, this.ownerID, this.totalMembers});
}


class CommunityChat {
  final String senderID;
  final String communityID;
  String message;
  String sender;
  int timestamp;

  CommunityChat({this.senderID, this.communityID, this.message, this.sender, this.timestamp});
}


class CommunityMember{
  final String uid;
  final String username;
  final String email;
  String image;


  CommunityMember({this.uid, this.email, this.username, this.image});
}