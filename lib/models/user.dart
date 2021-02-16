import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String username;
  String profileImage;

  UserModel({this.id, this.email, this.username, this.profileImage});
}
