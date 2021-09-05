import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';

class SignInEmail extends StatelessWidget {
  TextEditingController controller;
  SignInEmail({this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: (value) => value.isEmpty ? "Field is empty" : null,
        decoration: InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(color: subtextColor),
            suffixIcon: Icon(Icons.person, color: subtextColor),
            ),
      ),
    );
  }
}
