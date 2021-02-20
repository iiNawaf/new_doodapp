import 'package:doodapp/models/community.dart';
import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/home/community_list/community_search_input.dart';
import 'package:doodapp/widgets/home/community_list/show_all_communities.dart';
import 'package:flutter/material.dart';

class AllCommunitiesScreen extends StatefulWidget {
  static const routeName = "/screens/home/all_communities.dart";
  List<Community> communities;
  AllCommunitiesScreen({this.communities});

  @override
  _AllCommunitiesScreenState createState() => _AllCommunitiesScreenState();
}

class _AllCommunitiesScreenState extends State<AllCommunitiesScreen> {
  List<Community> searchedItems = List<Community>();
  @override
  void initState() {
    searchedItems.addAll(widget.communities);
    super.initState();
  }

  TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ApplicationBar(isAllCommunities: true, title: "All Communities"),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          CommunitySearchInput(
            controller: searchController,
            search: (value) {
              List<Community> tempCommunity = List<Community>();
              tempCommunity.addAll(searchedItems);
              if (value.isNotEmpty) {
                List<Community> communityResult = List<Community>();
                tempCommunity.forEach((item) {
                  if (item.title.toLowerCase().contains(value.toLowerCase())) {
                    communityResult.add(item);
                  }
                });
                setState(() {
                  searchedItems.clear();
                  searchedItems.addAll(communityResult);
                });
              } else {
                setState(() {
                  searchedItems.clear();
                  searchedItems.addAll(widget.communities);
                });
              }
            },
          ),
          GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisCount: 2,
              ),
              itemCount: searchedItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ShowAllCommunities(community: searchedItems[index]);
              }),
        ],
      ),
    );
  }
}
