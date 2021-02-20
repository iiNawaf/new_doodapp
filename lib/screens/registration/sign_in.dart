import 'package:doodapp/screens/registration/sign_up.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/registration/sign_in/email.dart';
import 'package:doodapp/widgets/registration/sign_in/password.dart';
import 'package:doodapp/widgets/registration/sign_in/submit_sign_in.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "/screens/registration/sign_in.dart";
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: SignInScreen.formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sign In", style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),),
                  SizedBox(height: 15),
                  SignInEmail(controller: emailController),
                  SizedBox(height: 30),
                  SignInPassword(controller: passwordController),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: SubmitSignIn(
                          emailController: emailController,
                          passwordController: passwordController,
                        )
                      ),
                      Expanded(
                        child: FlatButton(
                          onPressed: (){},
                          child: Text("Forgot Password?"),
                        )
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: () => Navigator.pushNamed(context, SignUpScreen.routeName),
                        child: Text("You don't have an account?", style: TextStyle(color: appColor, fontSize: 15, fontWeight: FontWeight.bold),)
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}