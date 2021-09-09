import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/communities/community_info/community_info.dart';
import 'package:doodapp/screens/communities/create_new_community/create_new_community.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:doodapp/shared/custom_dialog.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationBar extends StatelessWidget {
  bool isHome;
  bool isAppManager;
  bool isCreateNewCommunity;
  bool isAllCommunities;
  bool isCommunityChat;
  bool isCommunityInfo;
  String title;
  Community community;
  ApplicationBar({this.isHome, this.isCreateNewCommunity, this.isAllCommunities, this.isCommunityChat, this.title, this.community, this.isCommunityInfo, this.isAppManager});
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    final cp = Provider.of<CommunityProvider>(context);
    return AppBar(
      bottom: PreferredSize(
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
         color: subtextColor,
         height: 1.0,
      ),
        ],
      ),
      preferredSize: Size.fromHeight(1.0)
      ),
      title: Row(
        children: [
          isAppManager == true ? Container(
            decoration: BoxDecoration(
              border: Border.all(color: appColor, width: 2)
            ),
            height: 45,
            width: 45,
            child: CachedImage(url: authData.loggedInUser.profileImage),
          ) : Container(),
          isAppManager == true ? SizedBox(width: 10) : Container(),
          Text(title, style: TextStyle(color: titleColor, fontSize: 24))
        ],
      ),
      
      actions: [
        isHome == true
            ? IconButton(
              onPressed: () {
                final owner = cp.communityList.indexWhere((owner) => owner.ownerID == authData.loggedInUser.id);
                if(owner == -1){
                  Navigator.pushNamed(context, CreateNewCommunity.routeName);
                }else{
                  showDialog(
                    context: context,
                    builder: (context){
                      return AppAlertDialog(
                        title: Text("Can't create community!", style: TextStyle(fontSize: 21),),
                        content: Text("You have already created a community."),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text("Ok")
                            ),
                          )
                        ],
                      );
                    }
                  );
                }
              },
                icon: Icon(Icons.add, size: 29),
              )
            : isCommunityChat == true 
            ? IconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityInfoScreen(community: community))),
                icon: Icon(Icons.info, size: 29),
              ): Container()
      ],
    );
  }
}
