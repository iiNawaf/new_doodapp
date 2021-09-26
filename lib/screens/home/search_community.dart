import 'package:doodapp/models/community.dart';
import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/home/show_more_communities/community_search_input.dart';
import 'package:doodapp/widgets/home/show_more_communities/show_communities_result.dart';
import 'package:flutter/material.dart';

class SearchCommunityScreen extends StatefulWidget {
  List<Community> communityList;
  SearchCommunityScreen({this.communityList});

  @override
  _SearchCommunityScreenState createState() => _SearchCommunityScreenState();
}

class _SearchCommunityScreenState extends State<SearchCommunityScreen> {
  List<Community> searchedItems = List<Community>();
  @override
  void initState() {
    searchedItems.addAll(widget.communityList);
    super.initState();
  }

  TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ApplicationBar(isSearchCommunity: true, title: "Search For Communities"),
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
                  searchedItems.addAll(widget.communityList);
                });
              }
            },
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: searchedItems.length > 5 ? 5 : searchedItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ShowCommunitiesResult(community: searchedItems[index]);
              }),
          
        ],
      ),
    );
  }
}