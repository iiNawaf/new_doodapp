import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/screens/registration/sign_in.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubmitSignIn extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  SubmitSignIn(
      {required this.emailController, required this.passwordController});

  @override
  _SubmitSignInState createState() => _SubmitSignInState();
}

class _SubmitSignInState extends State<SubmitSignIn> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return isLoading
        ? GeneralLoading()
        : GestureDetector(
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              try {
                if (SignInScreen.formKey.currentState!.validate()) {
                  await auth.signIn(widget.emailController.text,
                      widget.passwordController.text);
                }
              } catch (e) {
                print(e);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      e.toString().contains("email address is badly formatted.")
                          ? "Email address is badly formatted."
                          : "Wrong email or password"),
                ));
              }
              setState(() {
                isLoading = false;
              });
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          );
  }
}
