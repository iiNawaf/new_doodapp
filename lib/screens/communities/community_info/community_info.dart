import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/wrapper/auth_wrapper.dart';
import 'package:doodapp/shared/custom_dialog.dart';
import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/communities/community_info/delete_community.dart';
import 'package:doodapp/widgets/communities/community_info/details.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityInfoScreen extends StatefulWidget {
  Community community;
  CommunityInfoScreen({this.community});

  @override
  _CommunityInfoScreenState createState() => _CommunityInfoScreenState();
}

class _CommunityInfoScreenState extends State<CommunityInfoScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<CommunityProvider>(context);
    final authData = Provider.of<AuthProvider>(context);
    print('${widget.community.ownerID} - ${authData.loggedInUser.id}');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child:
            ApplicationBar(isCommunityInfo: true, title: "Community Details"),
      ),
      body: Column(children: [
        CommunityDetails(community: widget.community),
        widget.community.ownerID == authData.loggedInUser.id
            ? DeleteCommunity(
                community: widget.community) : Container(),
      ]),
    );
  }
}
