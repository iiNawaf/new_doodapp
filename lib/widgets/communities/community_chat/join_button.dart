import 'package:doodapp/models/community.dart';
import 'package:doodapp/models/user.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinButton extends StatelessWidget {
  Community community;
  UserModel newMember;
  Function join;
  JoinButton({this.community, this.newMember, this.join});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: join,
      child: Container(
        height: 70,
        color: appColor,
        child: Center(
            child: Text(
          "Join",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        )),
      ),
    );
  }
}
