import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunitiesList extends StatefulWidget {
  List<Community> communities;
  CommunitiesList({@required this.communities});

  @override
  _CommunitiesListState createState() => _CommunitiesListState();
}

class _CommunitiesListState extends State<CommunitiesList> {
  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<CommunityProvider>(context);
    return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.communities.length > 10 ? 10 : widget.communities.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommunityChatScreen(community: widget.communities[index]))),
                      child: Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedImage(url: '${widget.communities[index].image}'),
              //             child: Stack(
              //               children: [
              //                 Center(child: CachedImage(url: '${widget.communities[index].image}')),
              //                  Padding(
              //   padding: const EdgeInsets.all(5),
              //   child: Container(
              //         height: 35,
              //         width: 55,
              //         decoration: BoxDecoration(
              //           color: appColor,
              //           borderRadius: BorderRadius.circular(25),
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             Icon(Icons.person, color: Colors.white),
              //             Text('${cp.communityMembers.length}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
              //           ]
              //         ),
              //       ),
              // ),
              //                  ],
              //                  )
                          ),
                        ),
                    ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${widget.communities[index].title}',overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                  ],
                ),
              );
            },
          );
  }
}
