import 'package:flutter/material.dart';

class Username extends StatelessWidget {
  final String username;
  Username({required this.username});
  @override
  Widget build(BuildContext context) {
    return Text(username,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }
}
