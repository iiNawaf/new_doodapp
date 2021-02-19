import 'package:doodapp/models/community.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:flutter/material.dart';


class CommunityDetails extends StatelessWidget {
  Community community;
  CommunityDetails({this.community});
  @override
  Widget build(BuildContext context) {
    return Container(
          width: MediaQuery.of(context).size.width,
          // color: appColor.withOpacity(0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    child: CachedImage(url: '${community.image}'),
                  ),
                ),
                Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Community Title:", style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: Text(
                "${community.title}",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Bio:", style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${community.bio}", style: TextStyle(fontSize: 16)),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("More details coming soon..."),
            ),
          ]),
        );
  }
}