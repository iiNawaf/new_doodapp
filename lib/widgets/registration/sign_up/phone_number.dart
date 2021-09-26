import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';

class PhoneNumber extends StatelessWidget {
  TextEditingController controller;
  PhoneNumber({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: tileColor
      ),
      child: TextFormField(
        maxLength: 10,
        controller: controller,
        validator: (value) {
          if(value.isEmpty){
            return "Field is empty";
          }else if(!value.startsWith("05") || value.length != 10){
            return "Please type a valid phone number";
          }else{
            return null;
          }
        },
        decoration: InputDecoration(
            labelText: "Phone Number",
            labelStyle: TextStyle(color: subtextColor),
            prefixIcon: Image.asset('./assets/icons/phone-call.png'),
            counterText: ""
      ),
      )
    );
  }
}