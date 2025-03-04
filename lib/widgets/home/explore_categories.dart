import 'package:doodapp/providers/category_provider.dart';
import 'package:doodapp/screens/home/show_all_category_communities.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:doodapp/shared/utilities.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class ExploreCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Container(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryProvider.categoryList?.length,
        itemBuilder: (ctx, index) {
          return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowAllCategoryCommunitiesScreen(
                      currentCategory: categoryProvider.categoryList?[index]))),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  child: Container(
                    width: 70,
                    decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          child: categoryProvider.categoryList![index].title ==
                                  "other"
                              ? Icon(
                                  Icons.more_horiz,
                                  color: Color(0xffffffff),
                                )
                              : CachedImage(
                                  url: categoryProvider
                                      .categoryList![index].image,
                                  isIcon: true),
                        ),
                        categoryTitle(
                            categoryProvider.categoryList![index].title,
                            titleColor),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}

Text categoryTitle(String title, Color textColor) {
  return Text(
    title == "social"
        ? "Social"
        : title == "music"
            ? "Music"
            : title == "movies_and_series"
                ? "Shows"
                : title == "business"
                    ? "Business"
                    : title == "sports"
                        ? "Sports"
                        : "Other",
    textAlign: TextAlign.center,
    style:
        TextStyle(fontWeight: FontWeight.bold, color: textColor, height: 1.5),
  );
}
