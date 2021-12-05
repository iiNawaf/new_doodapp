import 'package:flutter/material.dart';

class DooderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff707070)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Image.asset(
        "./assets/images/ghost.png",
        height: 35,
      ),
    );
  }
}
