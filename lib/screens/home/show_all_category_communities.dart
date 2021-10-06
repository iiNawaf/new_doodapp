import 'package:doodapp/models/category.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/home/explore_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowAllCategoryCommunitiesScreen extends StatelessWidget {
  Category currentCategory;
  ShowAllCategoryCommunitiesScreen({this.currentCategory});
  @override
  Widget build(BuildContext context) {
    final communityProvider = Provider.of<CommunityProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ApplicationBar(
            isCategoryCommunities: true,
            title: categoryTitle(currentCategory.title, titleBlackColor).data),
      ),
      body: communityProvider.communityList.length == 0
          ? Center(
              child: Text("No Communities Found"),
            )
          : ListView.builder(
              itemCount: communityProvider.communityList.length,
              itemBuilder: (ctx, index) => communityProvider
                          .communityList[index].categoryTitle ==
                      currentCategory.title
                  ? Padding(
                      padding:
                          const EdgeInsets.only(right: 15, left: 15, top: 8),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => CommunityChatScreen(
                                    community: communityProvider
                                        .communityList[index]))),
                        child: Container(
                          padding: EdgeInsets.all(10),
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
                                      child: CachedImage(
                                          url: communityProvider
                                              .communityList[index].image),
                                    ),
                                    height: 70,
                                    width: 70,
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    width: 230,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "${communityProvider.communityList[index].title}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              height: 1.4,
                                              fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "${communityProvider.communityList[index].bio}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: communitySubtitleColor)),
                                        // categoryTitle(
                                        //     communityProvider
                                        //         .communityList[index]
                                        //         .categoryTitle,
                                        //     communitySubtitleColor)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios,
                                  color: communitySubtitleColor),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ),
    );
  }
}
