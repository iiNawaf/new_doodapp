import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/communities/community_info/community_info.dart';
import 'package:doodapp/screens/communities/create_new_community/create_new_community.dart';
import 'package:doodapp/screens/home/search_community.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:doodapp/shared/custom_dialog.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationBar extends StatelessWidget {
  final bool? isHome;
  final bool? isAppManager;
  final bool? isCreateNewCommunity;
  final bool? isAllCommunities;
  final bool? isCommunityChat;
  final bool? isCommunityInfo;
  final bool? isSearchCommunity;
  final bool? isCategoryCommunities;
  final int? selectedIndex;
  final String? title;
  final Community? community;
  ApplicationBar({
    this.isHome,
    this.isCreateNewCommunity,
    this.isAllCommunities,
    this.isCommunityChat,
    this.title,
    this.community,
    this.isCommunityInfo,
    this.isAppManager,
    this.isSearchCommunity,
    this.isCategoryCommunities,
    this.selectedIndex,
  });
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    final cp = Provider.of<CommunityProvider>(context);
    return AppBar(
      backgroundColor: selectedIndex == 2 ? darkAppBar : bgColor,
      bottom: PreferredSize(
          child: Column(
            children: [
              SizedBox(height: 10),
              selectedIndex == 2
                  ? Container()
                  : Container(
                      color: subtextColor,
                      height: 1.0,
                    ),
            ],
          ),
          preferredSize: Size.fromHeight(1.0)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              selectedIndex == 2
                  ? CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xff424242),
                      child: Image.asset(
                        "./assets/images/ghost.png",
                        height: 35,
                      ),
                    )
                  : isAppManager == true
                      ? CachedImage(
                          url: authData.loggedInUser?.profileImage,
                          isProfileImg: true,
                          radius: 25,
                        )
                      : Container(),
              isAppManager == true ? SizedBox(width: 10) : Container(),
              Text(title ?? '',
                  style: TextStyle(
                      color: selectedIndex == 2
                          ? Color(0xffFFFFFF)
                          : Color(0xff000000),
                      fontSize: 20,
                      fontWeight: FontWeight.bold))
            ],
          ),
          isAppManager == true
              ? selectedIndex == 2
                  ? Container()
                  : GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchCommunityScreen(
                                    communityList: cp.communityList,
                                  ))),
                      child: CircleAvatar(
                        backgroundColor: circleBgColor,
                        child: Image.asset('./assets/icons/loupe.png'),
                      ),
                    )
              : Container()
        ],
      ),
      actions: [
        isHome == true
            ? IconButton(
                onPressed: () {
                  final owner = cp.communityList.indexWhere(
                      (owner) => owner.ownerID == authData.loggedInUser?.id);
                  if (owner == -1) {
                    Navigator.pushNamed(context, CreateNewCommunity.routeName);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AppAlertDialog(
                            title: Text(
                              "Can't create community!",
                              style: TextStyle(fontSize: 21),
                            ),
                            content:
                                Text("You have already created a community."),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Text("Ok")),
                              )
                            ],
                          );
                        });
                  }
                },
                icon: Icon(Icons.add, size: 29),
              )
            : isCommunityChat == true
                ? Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AppAlertDialog(
                                  content: Text(
                                      "Do you want to report this community?"),
                                  actions: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text("Yes"),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text("No"),
                                    )
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.flag, size: 29),
                      ),
                      IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CommunityInfoScreen(community: community!),
                          ),
                        ),
                        icon: Icon(Icons.info, size: 29),
                      )
                    ],
                  )
                : Container()
      ],
    );
  }
}
