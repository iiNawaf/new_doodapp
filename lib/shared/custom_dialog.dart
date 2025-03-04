import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  final bool? isDoodArea;
  AppAlertDialog({
    this.title,
    this.content,
    this.actions,
    this.isDoodArea,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        backgroundColor:
            isDoodArea == true ? Color(0xff303030) : Color(0xffffffff),
        contentTextStyle: TextStyle(color: Colors.black),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        title: title,
        content: content,
        actions: actions,
      ),
    );
  }
}
