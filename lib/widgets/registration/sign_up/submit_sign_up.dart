import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/screens/registration/sign_up.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubmitSignUp extends StatefulWidget {
  TextEditingController username;
  TextEditingController email;
  TextEditingController password;
  SubmitSignUp({this.password, this.email, this.username});

  @override
  _SubmitSignUpState createState() => _SubmitSignUpState();
}

class _SubmitSignUpState extends State<SubmitSignUp> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return isLoading
        ? GeneralLoading()
        : GestureDetector(
            onTap: () async {
              await _signUp(widget.username.text.toLowerCase(), auth);
            },
            child: Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                color: appColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          );
  }

  Future<void> _signUp(String username, AuthProvider auth) {
    try {
      if (SignUpScreen.formKey.currentState.validate()) {
        String tempUser = "";
        FirebaseFirestore.instance.collection('users_info').snapshots().listen((snapshot) async {
          snapshot.docs.forEach((doc) {
            print(doc.data()['username']);
            if (username == doc.data()['username']) {
              tempUser = doc.data()['username'];
            }
          });
          print("$tempUser - $username");
          if (tempUser != username) {
            setState(() {
              isLoading = true;
            });
            await auth.signUp(
                widget.email.text, widget.password.text, widget.username.text);
            Navigator.of(context).popUntil((route) => route.isFirst);
            setState(() {
              isLoading = false;
            });
          } else {
            SignUpScreen.scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Username is taken."),
            ));
          }
        });
      }
    } catch (e) {
      SignUpScreen.scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Email address is already exist. $e"),
      ));
    }
  }
}
