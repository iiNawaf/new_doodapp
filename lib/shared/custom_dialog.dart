import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  Widget title;
  Widget content;
  List<Widget> actions;
  AppAlertDialog({this.title, this.content, this.actions});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        contentTextStyle: TextStyle(color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        title: title,
        content: content,
        actions: actions,
      ),
    );
  }
}