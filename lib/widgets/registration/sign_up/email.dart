import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class SignUpEmail extends StatelessWidget {
  final TextEditingController controller;
  SignUpEmail({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: tileColor),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "Field is empty";
          } else if (!EmailValidator.validate(value) || value.contains(" ")) {
            return "Please type a valid email address";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(color: subtextColor),
            prefixIcon: Image.asset('./assets/icons/email.png')),
      ),
    );
  }
}
