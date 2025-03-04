import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';

class DooderContent extends StatelessWidget {
  final String content;
  DooderContent({required this.content});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 58),
      child: Text(
        content,
        style: TextStyle(color: titleColor),
      ),
    );
  }
}
