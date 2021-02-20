import 'package:doodapp/models/community.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:flutter/material.dart';

class ShowAllCommunities extends StatelessWidget {
  Community community;
  ShowAllCommunities({this.community});
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommunityChatScreen(community: community))),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedImage(url: community.image),
                  ),
                  Text("${community.title}")
                  ],
                )
              ),
            ),
          );
  }
}