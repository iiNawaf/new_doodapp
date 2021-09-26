import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';

class SignUpPassword extends StatelessWidget {
  TextEditingController controller;
  SignUpPassword({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: tileColor
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) => value.isEmpty ? "Field is empty" : null,
        obscureText: true,
        decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(color: subtextColor),
            prefixIcon: Image.asset('./assets/icons/padlock.png')
            ),
      ),
    );
  }
}
