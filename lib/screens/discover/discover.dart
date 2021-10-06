import 'package:doodapp/models/category.dart';
import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/category_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/screens/home/all_communities.dart';
import 'package:doodapp/screens/home/show_all_category_communities.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/home/explore_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final communityProvider = Provider.of<CommunityProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: categoryProvider.categoryList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titlePreview(
                              categoryProvider.categoryList[index],
                              communityProvider.communityList,
                              context),
                          Container(
                            height: 120,
                            child: ListView.builder(
                              itemCount: communityProvider.communityList.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index2) {
                                return communityProvider.communityList[index2].categoryTitle == categoryProvider.categoryList[index].title 
                                ? previewCommunityList(
                                        communityProvider.communityList[index2], context) : Container();
                              },
                            ),
                          ),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget titlePreview(
      Category category, List<Community> communityList, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        categoryTitle(category.title, titleBlackColor),
        GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ShowAllCategoryCommunitiesScreen(currentCategory: category))),
          child: Text(
            "Show More",
            style: TextStyle(color: appColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget previewCommunityList(Community community, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityChatScreen(community: community,))),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedImage(url: community.image),
          ),
          width: 120,
        ),
      ),
    );
  }
}
