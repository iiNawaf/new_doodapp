import 'package:flutter/material.dart';

class CommunityBio extends StatelessWidget {
  TextEditingController controller;
  CommunityBio({this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => value.isEmpty ? "Field is empty" : null,
      maxLines: 4,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        labelText: "Community Bio",
        border: OutlineInputBorder()
      ),
    );
  }
}
