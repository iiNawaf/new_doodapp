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
      key: SignUpScreen.scaffoldKey,
      appBar: AppBar(
          backgroundColor: bgColor,
          iconTheme: IconThemeData(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: SignUpScreen.formKey,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Text(
                "Join",
                style: TextStyle(fontSize: 40),
              ),
              Text(
                "DoodApp",
                style: TextStyle(
                    color: appColor, fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 80),
              Column(
                children: [
                  SignUpUsername(
                    controller: usernameController,
                  ),
                  SizedBox(height: 15),
                  SignUpEmail(controller: emailController),
                  SizedBox(height: 15),
                  PhoneNumber(controller: phoneNumberController),
                  SizedBox(height: 15),
                  SignUpPassword(controller: passwordController),
                  SizedBox(height: 15),
                  SignUpRePassword(passwordContoller: passwordController),
                  SizedBox(height: 40),
                  SubmitSignUp(
                    username: usernameController,
                    email: emailController,
                    password: passwordController,
                  )
                ],
              )
            ],
          ),
          // child: Center(
          //   child: SingleChildScrollView(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text("Sign Up",
          //          style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
          //          ),
          //         SizedBox(height: 15,),
          //         SignUpUsername(controller: usernameController,),
          //         SizedBox(height: 30),
          //         SignUpEmail(controller: emailController),
          //         SizedBox(height: 30),
          //         SignUpPassword(controller: passwordController),
          //         SizedBox(height: 30),
          //         SignUpRePassword(passwordContoller: passwordController),
          //         SizedBox(height: 50),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             SubmitSignUp(
          //               username: usernameController,
          //               email: emailController,
          //               password: passwordController,
          //             )
          //           ],
          //       )
          //       ],
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
