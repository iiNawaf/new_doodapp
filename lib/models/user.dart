
class UserModel {
  final String id;
  final String email;
  final String username;
  final int phoneNumber;
  String profileImage;
  String accountType;
  String status;
  List<dynamic> communitiesJoined;
  List<dynamic> blockedUsers;

  UserModel(
      {this.status,
      this.id,
      this.email,
      this.username,
      this.phoneNumber,
      this.profileImage,
      this.accountType,
      this.communitiesJoined,
      this.blockedUsers});
}
