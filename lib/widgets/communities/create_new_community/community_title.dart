import 'package:flutter/material.dart';

class CommunityTitle extends StatelessWidget {
  TextEditingController controller;
  CommunityTitle({this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
          validator: (value) {
            if(value.isEmpty){
              return "Field is empty";
            }else if(value.length > 20){
              return "You the max length is 20!";
            }else{
              return null;
            }
          },
          maxLength: 20,
          controller: controller,
          decoration: InputDecoration(
            labelText: "Community Title",
            counterText: ""
            ),
        );
  }
}
