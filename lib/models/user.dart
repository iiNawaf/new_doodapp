class UserModel {
  final String id;
  final String email;
  final String username;
  final int phoneNumber;
  String? profileImage;
  String? accountType;
  String? status;
  List<dynamic>? communitiesJoined;
  List<dynamic>? blockedUsers;
  bool? didAgreeTerms;

  UserModel({
    this.status,
    required this.id,
    required this.email,
    required this.username,
    required this.phoneNumber,
    this.profileImage,
    this.accountType,
    this.communitiesJoined,
    this.blockedUsers,
    this.didAgreeTerms,
  });
}
