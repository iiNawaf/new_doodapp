import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';

class SignInPassword extends StatelessWidget {
  TextEditingController controller;
  SignInPassword({this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: (value) => value.isEmpty ? "Field is empty" : null,
        obscureText: true,
        decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(color: subtextColor),
            suffixIcon: Icon(Icons.lock, color: subtextColor),
            ),
      ),
    );
  }
}
