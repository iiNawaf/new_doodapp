import 'package:doodapp/models/community.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:flutter/material.dart';

class CommunitiesList extends StatelessWidget {
  List<Community> communities;
  CommunitiesList({@required this.communities});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: communities.length > 10 ? 10 : communities.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              Center(child: Opacity(opacity: 0.7,child: CachedImage(url: '${communities[index].image}'))),
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text("Members: ${communities[index].totalMembers}"),
                               )
                               ],
                               )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${communities[index].title}',overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                  ],
                ),
              );
            },
          );
  }
}
