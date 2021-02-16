import 'package:doodapp/app_manager/app_manager.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/screens/registration/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: StreamBuilder(
        stream: authData.authStateChanges,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              authData.user = snapshot.data;
              return AppManager();
            } else {
              return SignInScreen();
            }
          }
        },
      ),
    );
  }
}
