import 'package:flutter/material.dart';

class SignUpRePassword extends StatelessWidget {
  TextEditingController passwordContoller;
  SignUpRePassword({this.passwordContoller});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: true,
        validator: (value) => value != passwordContoller.text ? "Password does not match" : null,
        decoration: InputDecoration(
            labelText: "Re-Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
