import 'package:flutter/material.dart';

class CommunityBio extends StatelessWidget {
  final TextEditingController controller;
  CommunityBio({required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "Field is empty";
        } else if (value.length > 150) {
          return "You the max length is 150!";
        } else {
          return null;
        }
      },
      maxLines: 4,
      maxLength: 150,
      cursorColor: Colors.grey,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: "Community Bio",
          border: OutlineInputBorder()),
    );
  }
}
