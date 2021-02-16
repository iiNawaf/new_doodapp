import 'package:flutter/material.dart';

class SignInUsername extends StatelessWidget {
  TextEditingController controller;
  SignInUsername({this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: (value) => value.isEmpty ? "Field is empty" : null,
        decoration: InputDecoration(
            labelText: "Username",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}