import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';

class AgreeButton extends StatefulWidget {
  final bool? didAgree;
  AgreeButton({this.didAgree});
  @override
  _AgreeButtonState createState() => _AgreeButtonState();
}

class _AgreeButtonState extends State<AgreeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: (widget.didAgree ?? false) ? appColor : Colors.grey,
      child: Center(
        child: Text(
          "Accept",
          style: TextStyle(
              color: titleColor, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }
}
