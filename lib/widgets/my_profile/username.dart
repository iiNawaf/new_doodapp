import 'package:flutter/material.dart';


class Username extends StatelessWidget {
  String username;
  Username({this.username});
  @override
  Widget build(BuildContext context) {
    return Text(username, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }
}