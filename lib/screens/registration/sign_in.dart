import 'package:doodapp/screens/registration/sign_up.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/registration/sign_in/email.dart';
import 'package:doodapp/widgets/registration/sign_in/password.dart';
import 'package:doodapp/widgets/registration/sign_in/submit_sign_in.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "/screens/registration/sign_in.dart";
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static bool? isUsernameError;
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Form(
        key: SignInScreen.formKey,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 80,
            ),
            _screenTitle(),
            SizedBox(height: 100),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    SignInEmail(controller: emailController),
                    SizedBox(height: 15),
                    SignInPassword(controller: passwordController),
                    SizedBox(height: 10),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {},
                    //       child: Text(
                    //         "Forgot Password?",
                    //         style: TextStyle(color: appColor, fontSize: 15),
                    //       ),
                    //     )
                    //   ],
                    // ),
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
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _screenTitle() {
  return Padding(
    padding: const EdgeInsets.only(right: 15, left: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sign In",
          style: TextStyle(
              fontSize: 32, color: titleColor, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
