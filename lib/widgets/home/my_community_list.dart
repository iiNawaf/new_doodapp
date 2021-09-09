import 'package:doodapp/models/community.dart';
import 'package:doodapp/models/user.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/screens/communities/create_new_community/create_new_community.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';

class MyCommunityList extends StatelessWidget {
  List<Community> communityList;
  UserModel loggedInUser;
  MyCommunityList(this.communityList, this.loggedInUser);
  bool myCommunityFound = false;
  @override
  Widget build(BuildContext context) {
    for(var i = 0; i < communityList.length; i++){
      if(communityList[i].ownerID == loggedInUser.id){
        myCommunityFound = true;
      }
    }
    return Column(
      children: [
        !myCommunityFound ? _createCommunityBtn(context) : Container(),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: communityList.length,
          itemBuilder: (context, index) {
            return loggedInUser.id != communityList[index].ownerID
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommunityChatScreen(
                                    community: communityList[index],
                                  ))),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: tileColor),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: CachedImage(
                                    url: communityList[index].image,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${communityList[index].title}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 3),
                                      Container(
                                        width: 250,
                                        child: Text(
                                          "${communityList[index].bio}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: subtextColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }
}

Widget _createCommunityBtn(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreateNewCommunity())),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: appColor),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ));
}
