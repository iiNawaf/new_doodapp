import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/home/live_chat/live_chat_input.dart';
import 'package:doodapp/widgets/home/live_chat/live_chat_list.dart';
import 'package:flutter/material.dart';

class LiveChatScreen extends StatelessWidget {
  TextEditingController messageController = TextEditingController();
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: LiveChatScreen.scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ApplicationBar(isLiveChat: true, title: "Dood Live Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(child: LiveChatList()),
          ),
          LiveChatInput(controller: messageController),
        ],
      ),
    );
  }
}
