import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/widgets/message/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final communityProvider = Provider.of<CommunityProvider>(context);
    final authData = Provider.of<AuthProvider>(context);
    
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
                          MessageTile(
                            communityProvider.communityList[index],
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
