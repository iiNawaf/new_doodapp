import 'package:doodapp/models/community.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/home/explore_categories.dart';
import 'package:flutter/material.dart';
import 'package:doodapp/shared/time.dart';

class RecentCommunitiesList extends StatelessWidget {
  List<Community> communityList;
  RecentCommunitiesList(this.communityList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: communityList == null
          ? 0
          : (communityList.length > 5 ? 5 : communityList.length),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: communityBorderColor)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${communityList[index].title}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        categoryTitle(communityList[index].categoryTitle, subtitleColor)
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: Text(
                            '${communityList[index].bio}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: communitySubtitleColor, height: 1.3),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommunityChatScreen(
                                  community: communityList[index],
                                ))),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: CachedImage(
                          url: communityList[index].image,
                          isCommunityImg: true),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CachedImage(
                                radius: 25,
                                  url: communityList[index].ownerProfileImg,
                                  isProfileImg: true),
                              SizedBox(width: 10),
                              Text("${communityList[index].ownerUsername}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))
                            ],
                          ),
                          Text(
                            "${Time.displayTimeAgoFromTimestamp(communityList[index].createTime.toDate().toString())}",
                            style: TextStyle(color: communitySubtitleColor),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        );
      },
    );
  }
}