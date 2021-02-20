import 'package:doodapp/models/community.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:flutter/material.dart';

class CommunitiesList extends StatelessWidget {
  Community community;
  RecentCommunity recentCommunity;
  CommunitiesList({this.community, this.recentCommunity});
  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                    onTap: () => community == null ? null : Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommunityChatScreen(community: community))),
                      child: Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedImage(url: community == null ? '${recentCommunity.image}' : '${community.image}'),
                          ),
                        ),
                    ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(community == null ? '${recentCommunity.title}' : '${community.title}', overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                  ],
                ),
              );
  }
}
