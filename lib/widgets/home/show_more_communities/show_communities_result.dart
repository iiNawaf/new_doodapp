import 'package:doodapp/models/community.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/home/explore_categories.dart';
import 'package:flutter/material.dart';

class ShowCommunitiesResult extends StatelessWidget {
  final Community community;
  ShowCommunitiesResult({required this.community});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, top: 8),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CommunityChatScreen(community: community))),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: tileColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedImage(url: community.image),
                    ),
                    height: 70,
                    width: 70,
                  ),
                  SizedBox(width: 5),
                  Container(
                    width: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${community.title}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Container(
                          width: 250,
                          child: Text(
                              " ${categoryTitle(community.categoryTitle, appColor).data} ${community.bio}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: communitySubtitleColor)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: communitySubtitleColor),
            ],
          ),
        ),
      ),
    );
  }
}
