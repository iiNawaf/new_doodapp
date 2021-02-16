import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier{
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  UserModel loggedInUser;

  // Stream authentication state
  Stream<User> get authStateChanges => _auth.authStateChanges();

  Future signIn(String email, String password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      print("Sign in Error $e");
      return null;
    }
  }

  Future signUp(String email, String password, String username) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await createUserData(result.user.uid, email, username);
    }catch(e){
      print("Sign Up Error $e");
      return null;
    }
  }

  Future signOut() async{
    await _auth.signOut();
  }

  // Database operations
  final usersCollection = FirebaseFirestore.instance.collection('users');
  
  Future createUserData(String id, String email, String username) async{
    await usersCollection.doc(id).set({
      'id': id,
      'email': email,
      'username': username,
      'profile_image': 'https://firebasestorage.googleapis.com/v0/b/doodapp-ebf46.appspot.com/o/users_images%2F23848476-cute-pink-worm-cartoon.jpg?alt=media&token=f3a1d4c3-3bf0-4485-9af6-905e040841b8'
    });
  }

  Future<void> fetchUserData() async{
    final snapshot = await usersCollection.doc(user.uid).get();
    loggedInUser = UserModel(
      id: user.uid,
      email: user.email,
      username: snapshot.data()['username'],
      profileImage: snapshot.data()['profile_image'],
    );
  }

}