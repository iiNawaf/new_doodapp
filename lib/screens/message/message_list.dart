import 'package:doodapp/models/community.dart';
import 'package:doodapp/models/user.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/message/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageListScreen extends StatefulWidget {
  @override
  _MessageListScreenState createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  bool isPrivate = false;
  @override
  Widget build(BuildContext context) {
    final communityProvider = Provider.of<CommunityProvider>(context);
    final authData = Provider.of<AuthProvider>(context);
    // communityProvider.fetchCommunityList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildListButton(),
            _buildMessageList(
                authData.loggedInUser, communityProvider.communityList),
          ],
        ),
      ),
    );
  }

  Widget _buildListButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 25,
      decoration: BoxDecoration(
          color: circleBgColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isPrivate = false;
                });
              },
              child: Container(
                height: 25,
                decoration: BoxDecoration(
                    color: isPrivate ? circleBgColor : appColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text("Communities",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isPrivate ? Color(0xffb7b2b2) : titleColor)),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isPrivate = true;
                });
              },
              child: Container(
                height: 25,
                decoration: BoxDecoration(
                    color: isPrivate ? appColor : circleBgColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text("Private",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isPrivate ? titleColor : Color(0xffB7B2B2))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(UserModel user, List<Community> communityList) {
    return isPrivate
        ? Center(
            child: Text("Private messages are not supported in this version."),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: communityList.length,
            itemBuilder: (ctx, index) {
              return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    child: CachedImage(
                      url: communityList[index].image,
                      isCommunityImg: true,
                    ),
                  ),
                  Column(
                    children: [
                      Text("${communityList[index].title}"),
                      Text("${communityList[index].bio}"),
                    ],
                  )
                ],
              ));
            });
  }
}
