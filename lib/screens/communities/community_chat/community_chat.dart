import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/communities/community_chat/chat_content.dart';
import 'package:doodapp/widgets/communities/community_chat/chat_text_field.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityChatScreen extends StatefulWidget {
  static String routeName = "/screens/communities/community_chat.dart";
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Community community;
  CommunityChatScreen({this.community});

  @override
  _CommunityChatScreenState createState() => _CommunityChatScreenState();
}

class _CommunityChatScreenState extends State<CommunityChatScreen> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<CommunityProvider>(context);
    return Scaffold(
      key: CommunityChatScreen.scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ApplicationBar(
            isCommunityChat: true,
            title: "${widget.community.title}",
            community: widget.community,
      ),
      ),
      body: Form(
              key: CommunityChatScreen.formKey,
              child: Column(children: [
                Expanded(
                  child: StreamBuilder<List<CommunityChat>>(
                    stream: cp.loadChatList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return GeneralLoading();
                      if (!snapshot.hasData) return Text("No Messages");
                      return ListView.builder(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          reverse: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ChatContent(
                                  communityChat: snapshot.data[index],
                                  community: widget.community),
                            );
                          });
                    },
                  ),
                ),

                ChatTextField(
                            controller: messageController,
                            community: widget.community)
              ]),
            ),
    );
  }
}
