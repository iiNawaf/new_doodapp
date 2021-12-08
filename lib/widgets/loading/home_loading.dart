import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Please wait...",
        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        SpinKitPulse(color: appColor),
      ],
    );
  }
}
