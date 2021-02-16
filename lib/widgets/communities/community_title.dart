import 'package:flutter/material.dart';

class CommunityTitle extends StatelessWidget {
  TextEditingController controller;
  CommunityTitle({this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => value.isEmpty ? "Field is empty" : null,
      controller: controller,
      decoration: InputDecoration(labelText: "Community Title"),
    );
  }
}
