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
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
