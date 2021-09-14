import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/widgets/message/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageListScreen extends StatefulWidget {
  static bool isChatScreen = false;

  @override
  _MessageListScreenState createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  @override
  Widget build(BuildContext context) {
    final communityProvider = Provider.of<CommunityProvider>(context);
    final authData = Provider.of<AuthProvider>(context);
    final args = ModalRoute.of(context).settings.arguments as List<Community>;
    communityProvider.fetchCommunityList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ListView.builder(
                itemCount: communityProvider.communityList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return authData.loggedInUser.communitiesJoined[index] ==
                          communityProvider.communityList[index].id
                      ? Column(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommunityChatScreen(
                                          community: communityProvider
                                              .communityList[index],
                                        )),
                              ),
                              child: MessageTile(
                                communityProvider.communityList[index],
                              ),
                            ),
                            SizedBox(height: 15)
                          ],
                        )
                      : Container();
                }),
          ],
        ),
      ),
    );
  }
}
