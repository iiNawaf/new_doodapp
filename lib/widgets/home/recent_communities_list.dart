import 'package:doodapp/models/community.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';

class RecentCommunitiesList extends StatelessWidget {
  List<Community> communityList;
  RecentCommunitiesList(this.communityList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: communityList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CommunityChatScreen(
                          community: communityList[index],
                        ))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: appColor),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "${communityList[index].image}"))),
                      height: 70,
                      width: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: [
                          Text(
                            "${communityList[index].title}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${communityList[index].bio}",
                            style: TextStyle(fontSize: 14, color: subtextColor),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        );
      },
    );
  }
}
