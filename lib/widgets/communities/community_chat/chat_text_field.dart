import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatTextField extends StatefulWidget {
  final TextEditingController controller;
  final Community? community;
  ChatTextField({required this.controller, this.community});

  @override
  _ChatTextFieldState createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    final communityProvider = Provider.of<CommunityProvider>(context);
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      child: TextFormField(
        controller: widget.controller,
        validator: (value) => value!.isEmpty ? "" : null,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            hintText: "Type a message...",
            suffixIcon: isLoading
                ? Icon(Icons.send, color: appColor)
                : GestureDetector(
                    onTap: isLoading
                        ? null
                        : () {
                            if (CommunityChatScreen.formKey.currentState!
                                .validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              communityProvider.sendMessageToCommunity(
                                authData.loggedInUser?.id ?? '',
                                widget.community?.id ?? '',
                                widget.controller.text,
                                authData.loggedInUser?.username ?? '',
                                widget.community?.title ?? '',
                                widget.community?.image ?? '',
                                widget.community?.bio ?? '',
                              );
                              widget.controller.clear();
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                    child: Icon(
                      Icons.send,
                      color: appColor,
                    ),
                  )),
      ),
    );
  }
}
