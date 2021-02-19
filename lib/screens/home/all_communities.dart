import 'package:doodapp/models/community.dart';
import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/home/show_all_communities.dart';
import 'package:flutter/material.dart';


class AllCommunitiesScreen extends StatelessWidget {
  static const routeName = "/screens/home/all_communities.dart";
  List<Community> communities;
  AllCommunitiesScreen({this.communities});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ApplicationBar(isAllCommunities: true, title: "All Communities"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.5,
          crossAxisCount: 2,
        ),
        itemCount: communities.length,
        itemBuilder: (BuildContext context, int index){
          return ShowAllCommunities(community: communities[index]);
        }
      ),
    );
  }
}