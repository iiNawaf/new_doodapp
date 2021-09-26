import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';

class SignInPassword extends StatelessWidget {
  TextEditingController controller;
  SignInPassword({this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: tileColor),
      child: TextFormField(
        controller: controller,
        validator: (value) => value.isEmpty ? "" : null,
        obscureText: true,
        decoration: InputDecoration(
          errorStyle: TextStyle(height: 0),
          labelText: "Password",
          labelStyle: TextStyle(color: subtextColor),
          prefixIcon: Image.asset('./assets/icons/padlock.png'),
        ),
      ),
    );
  }
}
