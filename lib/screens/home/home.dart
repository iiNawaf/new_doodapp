import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/providers/live_chat_provider.dart';
import 'package:doodapp/screens/home/all_communities.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/home/communities_list.dart';
import 'package:doodapp/widgets/home/timeline.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/screens/home/home.dart";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController liveChatController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    liveChatController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    final community = Provider.of<CommunityProvider>(context);
    final liveChatProvider = Provider.of<LiveChatProvider>(context);
    // community.fetchCommunityList();
    return Scaffold(
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
                await community.fetchCommunityList();
                setState(() {
                  isLoading = false;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Communities
                        _communityTitle(context, community.communityList),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: community.communityList.isEmpty
                              ? Center(
                                  child: Text("No communities available."),
                                )
                              : Container(
                                  height: 150,
                                  child: CommunitiesList(
                                      communities: community.communityList)),
                        ),

                        // timeline
                        _timelineTitle(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: TimelineList()),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 90,
                    color: Colors.white,
                    child: TextField(
                      controller: liveChatController,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            if (liveChatController.text == "") {
                              return null;
                            } else {
                              await liveChatProvider.sendToLiveChat(
                                  authData.loggedInUser.id,
                                  authData.loggedInUser.username,
                                  authData.loggedInUser.profileImage,
                                  authData.loggedInUser.email);
                              liveChatController.clear();
                            }
                          },
                          child: Icon(Icons.send),
                        ),
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

Widget _timelineTitle() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      "Live Chat",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
  );
}
