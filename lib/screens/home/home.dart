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
import 'package:doodapp/widgets/home/user_image.dart';
import 'package:doodapp/widgets/home/username.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
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

  @override
  void dispose() {
    liveChatController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final communityProvider = Provider.of<CommunityProvider>(context);
    final authData = Provider.of<AuthProvider>(context);
    // authData.signOut();
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ApplicationBar(isHome: true, title: "Dood"),
      ),
      body: isLoading
          ? GeneralLoading()
          : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  isLoading = true;
                });
                HomeScreen.userImage = null;
                await authData.fetchUserData();
                await communityProvider.fetchCommunityList();
                setState(() {
                  isLoading = false;
                });
              },
              child: ListView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                shrinkWrap: true,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 250,
                    color: appColor.withOpacity(0.1),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                            UserImage(scaffoldKey: _scaffoldKey),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Welcome",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                                Username(username: authData.loggedInUser.username),
                              ],
                            )
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _liveChatButton(context),
                              _signOutButton(context, authData)
                            ],
                          )
                        ]),
                  ),
                  
                  // Communities
                  _communityTitle(context, communityProvider.communityList),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: communityProvider.communityList.isEmpty
                        ? Center(
                            child: Text("No communities available."),
                          )
                        : Container(
                            height: 150,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  communityProvider.communityList.length > 10
                                      ? 10
                                      : communityProvider.communityList.length,
                              itemBuilder: (context, index) {
                                return CommunitiesList(
                                    community:
                                        communityProvider.communityList[index]);
                              },
                            ),
                          ),
                  ),

                  // my community
                  _myCommunityTitle(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: communityProvider.communityList.isEmpty
                        ? Center(
                            child: Text("No communities available."),
                          )
                        : Container(
                            height: 150,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                int ownerIndex = communityProvider.communityList
                                    .indexWhere((com) =>
                                        com.ownerID ==
                                        authData.loggedInUser.id);
                                return ownerIndex == -1
                                    ? Text("You don't have a community.")
                                    : CommunitiesList(
                                        community: communityProvider
                                            .communityList[ownerIndex]);
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}

Widget _communityTitle(BuildContext context, List<Community> communities) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Communities",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AllCommunitiesScreen(communities: communities))),
            child: Text(
              "Show more",
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

Widget _signOutButton(BuildContext context, AuthProvider authData) {
  return GestureDetector(
    child: Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(5)),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.logout),
          Text(
            "Sign out",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      )),
    ),
    onTap: () {
      showDialog(
          context: context,
          builder: (context) {
            return AppAlertDialog(
              title: Text(
                "Sign out",
                style: TextStyle(fontSize: 21),
              ),
              content: Text("Are you sure you want to sign out?"),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        authData.signOut();
                        Navigator.pop(context);
                      },
                      child: Text("Sign out")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text("Cancel")),
                ),
              ],
            );
          });
    },
  );
}

Widget _liveChatButton(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LiveChatScreen())),
    child: Container(
      height: 50,
      width: 100,
      decoration:
          BoxDecoration(color: appColor, borderRadius: BorderRadius.circular(5)),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.chat_bubble_outline, color: Colors.white),
          Text(
            "Live Chat",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      )),
    ),
  );
}
