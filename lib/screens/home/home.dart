import 'dart:io';

import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/communities/create_new_community/create_new_community.dart';
import 'package:doodapp/screens/home/all_communities.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/home/explore_categories.dart';
import 'package:doodapp/widgets/home/home_carousel.dart';
import 'package:doodapp/widgets/home/recent_communities_list.dart';
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

  @override
  Widget build(BuildContext context) {
    final communityProvider = Provider.of<CommunityProvider>(context);
    final authData = Provider.of<AuthProvider>(context);
    return authData.loggedInUser.status == "blocked"
        ? accountBlockedMessage(authData)
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: appColor,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CreateNewCommunity())),
              child: Icon(Icons.add),
            ),
            key: _scaffoldKey,
            body: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  HomeCarousel(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //explore
                        _exploreCategoryTitle(),
                        ExploreCategories(),
                        SizedBox(height: 5),
                        // recent communities
                        _recentCommunitiesTitle(
                            context, communityProvider.communityList),
                        SizedBox(height: 10),
                        RecentCommunitiesList(communityProvider.communityList),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

Widget _exploreCategoryTitle() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Categories",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget _recentCommunitiesTitle(
    BuildContext context, List<Community> communities) {
  return Row(
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
          "Show More",
          style: TextStyle(color: appColor, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
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
