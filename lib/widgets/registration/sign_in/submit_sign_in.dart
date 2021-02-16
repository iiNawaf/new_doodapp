import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/screens/registration/sign_in.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubmitSignIn extends StatelessWidget {
  TextEditingController emailController;
  TextEditingController passwordController;
  SubmitSignIn({this.emailController, this.passwordController});
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: () async{
        if(SignInScreen.formKey.currentState.validate()){
          await auth.signIn(emailController.text, passwordController.text);
          
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: appColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "Sign In",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
