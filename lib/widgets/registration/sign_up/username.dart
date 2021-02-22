import 'package:flutter/material.dart';

class SignUpUsername extends StatelessWidget {
  TextEditingController controller;
  SignUpUsername({this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        validator: (value) {
            Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
            RegExp regex = RegExp(pattern);
          if(value.isEmpty){
            return "Field is empty";
          }else if(!regex.hasMatch(value)){
            return "Please type a valid username";
          }else if(value.length > 15){
            return "The maximum length of username is 15!";
          }else{
            return null;
          }
        },
        decoration: InputDecoration(
            labelText: "Username",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}