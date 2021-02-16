import 'package:flutter/material.dart';

class SignUpPassword extends StatelessWidget {
  TextEditingController controller;
  SignUpPassword({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: (value) => value.isEmpty ? "Field is empty" : null,
        obscureText: true,
        decoration: InputDecoration(
            labelText: "Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
