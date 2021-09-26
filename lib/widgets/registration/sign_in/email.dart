import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';

class SignInEmail extends StatelessWidget {
  TextEditingController controller;
  SignInEmail({this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: tileColor
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) => value.isEmpty ? "" : null,
        decoration: InputDecoration(
          errorStyle: TextStyle(height: 0),
          labelText: "Email",
          prefixIcon: Image.asset('./assets/icons/user.png'),
          
        ),
      ),
    );
  }
}
