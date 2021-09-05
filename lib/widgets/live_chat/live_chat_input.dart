import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/live_chat_provider.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LiveChatInput extends StatefulWidget {
  TextEditingController controller;
  LiveChatInput({this.controller});

  @override
  _LiveChatInputState createState() => _LiveChatInputState();
}

class _LiveChatInputState extends State<LiveChatInput> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    final liveChatProvider = Provider.of<LiveChatProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 70,
      color: Colors.white,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: "Type a message...",
          suffixIcon: isLoading ? Icon(Icons.send, color: appColor): GestureDetector(
            onTap: () async {
              if (widget.controller.text == "") {
                return null;
              } else {
                setState(() {
                  isLoading = true;
                });
                await liveChatProvider.sendToLiveChat(
                    widget.controller.text,
                    authData.loggedInUser.id,
                    authData.loggedInUser.username,
                    authData.loggedInUser.profileImage,
                    authData.loggedInUser.email);
                widget.controller.clear();
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: Icon(Icons.send, color: appColor),
          ),
        ),
      ),
    );
  }
}
