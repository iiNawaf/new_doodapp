import 'package:flutter/material.dart';

class CommunityBio extends StatelessWidget {
  TextEditingController controller;
  CommunityBio({this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value.isEmpty) {
          return "Field is empty";
        } else if (value.length > 150) {
          return "You the max length is 150!";
        } else {
          return null;
        }
      },
      maxLines: 4,
      maxLength: 150,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
          labelText: "Community Bio", border: OutlineInputBorder()),
    );
  }
}
