import 'package:doodapp/admin_panel/admin_panel.dart';
import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/communities/community_info/community_info.dart';
import 'package:doodapp/screens/communities/create_new_community/create_new_community.dart';
import 'package:doodapp/shared/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationBar extends StatelessWidget {
  bool isHome;
  bool isCreateNewCommunity;
  bool isAllCommunities;
  bool isCommunityChat;
  bool isCommunityInfo;
  bool isLiveChat;
  bool isAdminPanel;
  String title;
  Community community;
  ApplicationBar({this.isHome, this.isCreateNewCommunity, this.isAllCommunities, this.isCommunityChat, this.title, this.community, this.isCommunityInfo, this.isLiveChat, this.isAdminPanel});
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    final cp = Provider.of<CommunityProvider>(context);
    return AppBar(
      elevation: 0,
      title: Text(title),
      leading: authData.loggedInUser.accountType == "admin" && isAdminPanel != true && isHome == true
      ? IconButton(icon: Icon(Icons.admin_panel_settings_outlined), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPanelScreen())),)
      : null,
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
