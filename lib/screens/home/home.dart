import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
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
  bool isInit = true;
  bool isLoading = false;
  @override
  void didChangeDependencies() async {
    if (isInit) {
      isInit = false;
      setState(() {
        isLoading = true;
      });
      await Provider.of<CommunityProvider>(context).fetchCommunityList();
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    final community = Provider.of<CommunityProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ApplicationBar(isHome: true),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Communities
                _communityTitle(),
                isLoading ? GeneralLoading() 
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 150, child: CommunitiesList(communities: community.communityList)),
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
              decoration: InputDecoration(
                // border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: () => null,
                  child: Icon(Icons.send),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _communityTitle() {
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
            onTap: () => null,
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
      "Timeline",
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
  );
}
