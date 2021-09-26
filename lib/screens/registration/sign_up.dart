import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/registration/sign_up/email.dart';
import 'package:doodapp/widgets/registration/sign_up/password.dart';
import 'package:doodapp/widgets/registration/sign_up/phone_number.dart';
import 'package:doodapp/widgets/registration/sign_up/re_password.dart';
import 'package:doodapp/widgets/registration/sign_up/submit_sign_up.dart';
import 'package:doodapp/widgets/registration/sign_up/username.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/screens/registration/sign_up.dart";
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: appColor,
      key: SignUpScreen.scaffoldKey,
      body: Form(
        key: SignUpScreen.formKey,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(height: 60),
            _screenTitle(),
            SizedBox(height: 80),
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
                    SignUpUsername(
                      controller: usernameController,
                    ),
                    SizedBox(height: 15),
                    SignUpEmail(controller: emailController),
                    SizedBox(height: 15),
                    PhoneNumber(controller: phoneNumberController),
                    SizedBox(height: 15),
                    SignUpPassword(controller: passwordController),
                    SizedBox(height: 40),
                    SubmitSignUp(
                      username: usernameController,
                      email: emailController,
                      password: passwordController,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ", style: TextStyle(fontSize: 15),),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text("Sign In", style: TextStyle(fontWeight: FontWeight.bold, color: appColor, fontSize: 15),),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
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
          "Create Your Account",
          style: TextStyle(
              fontSize: 32, color: titleColor, fontWeight: FontWeight.bold),
        ),
        Text(
          "Join DoodApp family and start exploring communities and expand your relationships",
          style: TextStyle(color: subtitleColor, fontSize: 14),
        ),
      ],
    ),
  );
}
