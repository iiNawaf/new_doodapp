import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  DocumentReference docRef;
  User user;
  UserModel loggedInUser;

  // Stream authentication state
  Stream<User> get authStateChanges => _auth.authStateChanges();

  Future signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future signUp(String email, String password, String username) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (result.user != null) {
      await createUserData(result.user.uid, email, username);
    }
  }

  void signOut() async {
    await _auth.signOut();
  }

  // Database operations
  final usersCollection = FirebaseFirestore.instance.collection('users');

  Future createUserData(String id, String email, String username) async {
    await usersCollection.doc(id).set({
      'id': id,
      'email': email,
      'username': username.toLowerCase(),
      'profile_image':
          'https://firebasestorage.googleapis.com/v0/b/doodapp-ebf46.appspot.com/o/users_images%2F23848476-cute-pink-worm-cartoon.jpg?alt=media&token=f3a1d4c3-3bf0-4485-9af6-905e040841b8',
      'account_type': 'normal_user',
      'status': 'active',
    });
  }

  Future<void> fetchUserData() async {
    final snapshot = await usersCollection.doc(user.uid).get();
    loggedInUser = UserModel(
      id: user.uid,
      email: user.email,
      username: snapshot.data()['username'],
      profileImage: snapshot.data()['profile_image'],
      accountType: snapshot.data()['account_type'],
      status: snapshot.data()['status'],
    );
  }

  Future<void> updateUserImage(String uid, File image) async {
    docRef = usersCollection.doc(uid);
    Reference reference =
        FirebaseStorage.instance.ref().child('users_images/${docRef.id}');
    String imgUrl;
    await reference.putFile(image).whenComplete(() async {
      await reference.getDownloadURL().then((value) {
        imgUrl = value;
      });
    });
    await docRef.update({'profile_image': imgUrl});
  }

}
