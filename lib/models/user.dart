class UserModel {
  final String id;
  final String email;
  final String username;
  String profileImage;
  String accountType;
  String status;

  UserModel({this.status, this.id, this.email, this.username, this.profileImage, this.accountType});
}
