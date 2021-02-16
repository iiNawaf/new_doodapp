import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/screens/registration/sign_up.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubmitSignUp extends StatelessWidget {
  TextEditingController username;
  TextEditingController email;
  TextEditingController password;
  SubmitSignUp({this.password, this.email, this.username});
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () async{
        if(SignUpScreen.formKey.currentState.validate()){
          await auth.signUp(email.text, password.text, username.text);
          Navigator.of(context).popUntil((route) => route.isFirst);
          print("Account created !");
        }else{
          print("enter inputs");
        }
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
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
