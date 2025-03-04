import 'package:doodapp/shared/time.dart';
import 'package:flutter/material.dart';

class DooderTime extends StatelessWidget {
  final dynamic time;
  DooderTime({this.time});
  @override
  Widget build(BuildContext context) {
    return Text(
      "${Time.displayTimeAgoFromTimestamp(time.toDate().toString())}",
      style: TextStyle(color: Color(0xff707070)),
    );
  }
}
