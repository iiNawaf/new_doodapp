import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/shared/custom_dialog.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/communities/community_info/details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityInfoScreen extends StatelessWidget {
  Community community;
  CommunityInfoScreen({this.community});
  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<CommunityProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ApplicationBar(isCommunityInfo: true, title: "Community Details"),
      ),
      body: Column(children: [
        CommunityDetails(community: community),
        GestureDetector(
          onTap: () async {
            showDialog(
                context: context,
                builder: (context) => AppAlertDialog(
                      title: Text(
                        "Delete ${community.title}",
                        style: TextStyle(fontSize: 21),
                      ),
                      content: Text(
                          "Are you sure you want to delete your community? "),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () async {
                              await cp.deleteCommunity(community.id);
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            },
                            child: Text("Yes") 
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Text("Cancel"),
                          ),
                        ),
                      ],
                    ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              color: appColor,
              child: Center(
                child: Text(
                  "Delete",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(10),
        //   child: Row(
        //     children: [
        //       Text(
        //         "Members (${members.length})",
        //         style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        //       ),
        //     ],
        //   ),
        // ),
        // MembersList(members: members, community: community),
      ]),
    );
  }
}
