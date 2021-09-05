import 'dart:io';

import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/home/all_communities.dart';
import 'package:doodapp/screens/live_chat/live_chat.dart';
import 'package:doodapp/shared/custom_dialog.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/home/community_list/communities_list.dart';
import 'package:doodapp/widgets/home/home_carousel.dart';
import 'package:doodapp/widgets/home/recent_communities_list.dart';
import 'package:doodapp/widgets/home/user_image.dart';
import 'package:doodapp/widgets/home/username.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/screens/home/home.dart";
  static File userImage;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController liveChatController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool isInit = true;

  @override
  void dispose() {
    liveChatController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final communityProvider = Provider.of<CommunityProvider>(context);
    final authData = Provider.of<AuthProvider>(context);
    return authData.loggedInUser.status == "blocked"
        ? accountBlockedMessage(authData)
        : Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HomeCarousel(),
                  _liveChatBtn(context),
                  // recent communities
                  _recentCommunitiesText(
                      context, communityProvider.communityList),
                  RecentCommunitiesList(communityProvider.communityList),
                ],
              ),
            ),
          );
  }
}

Widget _liveChatBtn(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LiveChatScreen())),
    child: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        height: 50,
        color: appColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Join DoodApp Live Chat",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xffffffff),
            )
          ],
        )),
  );
}

Widget _recentCommunitiesText(
    BuildContext context, List<Community> communities) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Recent Communities",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AllCommunitiesScreen(communities: communities))),
            child: Text(
              "Show All",
              style: TextStyle(color: appColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ));
}

Widget _myCommunityTitle() {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "My Community",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ));
}

Widget accountBlockedMessage(AuthProvider authData) {
  return Scaffold(
    body: Center(
        child: Container(
      padding: EdgeInsets.all(15),
      height: 250,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Unfortunately, your account is blocked!",
          ),
          GestureDetector(
            onTap: () => authData.signOut(),
            child: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: appColor, borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text("Go back",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
            ),
          )
        ],
      ),
    )),
  );
}
