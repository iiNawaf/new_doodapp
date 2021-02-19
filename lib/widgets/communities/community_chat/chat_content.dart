import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class ChatContent extends StatelessWidget {
  CommunityChat communityChat;
  Community community;
  ChatContent({this.communityChat, this.community});

  String formatTimestamp(Timestamp timestamp) {
    try{
    var format = new DateFormat('d MMM, hh:mm a');
    var date = timestamp.toDate();
    return format.format(date);
    }catch(e){
      return "Sending...";
    }
  }

  bool isSender(AuthProvider authProvider){
    if(authProvider.loggedInUser.id == communityChat.senderID){
      return true;
    }else{
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    return community.id == communityChat.communityID 
    ? Column(
      crossAxisAlignment: authData.loggedInUser.id == communityChat.senderID 
      ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: isSender(authData) ? appColor : appColor.withOpacity(0.4),
            borderRadius: isSender(authData)
            ? BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ) : BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ) 
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(isSender(authData) ? "You" : "${communityChat.sender}", style: TextStyle(color: isSender(authData) ? Colors.yellow[800] : appColor, fontSize: 15, fontWeight: FontWeight.bold),),
              SizedBox(height: 8),
              Text("${communityChat.content}", style: TextStyle(color: Colors.white, fontSize: 15),),
              SizedBox(height: 5),
              Text("${formatTimestamp(communityChat.timestamp)}", style: TextStyle(fontSize: 12),)
            ]
          ),
        ),
      ]
    ) : Container();
  }
}