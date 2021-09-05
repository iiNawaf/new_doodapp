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
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Welcome To ",
                style: TextStyle(fontSize: 40),
              ),
              Text(
                "DoodApp",
                style: TextStyle(
                    color: appColor, fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 120),
              Column(
                  children: [
                    SignInEmail(controller: emailController),
                    SizedBox(height: 15),
                    SignInPassword(controller: passwordController),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: appColor, fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 40),
                    SubmitSignIn(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 15),
                        ),
                        GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, SignUpScreen.routeName),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: appColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
