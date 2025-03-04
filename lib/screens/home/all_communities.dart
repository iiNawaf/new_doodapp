import 'package:doodapp/models/community.dart';
import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/home/show_more_communities/show_communities_result.dart';
import 'package:flutter/material.dart';

class AllCommunitiesScreen extends StatefulWidget {
  static const routeName = "/screens/home/all_communities.dart";
  final List<Community>? communities;
  AllCommunitiesScreen({this.communities});

  @override
  _AllCommunitiesScreenState createState() => _AllCommunitiesScreenState();
}

class _AllCommunitiesScreenState extends State<AllCommunitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ApplicationBar(isAllCommunities: true, title: "All Communities"),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.communities?.length,
          itemBuilder: (BuildContext context, int index) {
            return ShowCommunitiesResult(community: widget.communities![index]);
          }),
    );
  }
}
