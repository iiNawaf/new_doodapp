import 'package:doodapp/models/community.dart';
import 'package:doodapp/models/user.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/shared/cached_image.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/home/user_image.dart';
import 'package:doodapp/widgets/my_profile/username.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool isMyCommunity = true;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final communityProvider = Provider.of<CommunityProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            UserImage(),
            Username(username: authProvider.loggedInUser?.username ?? ''),
            SizedBox(height: 20),
            _switchButton(),
            SizedBox(height: 10),
            _switchResult(
                authProvider.loggedInUser!, communityProvider.communityList),
            GestureDetector(
              onTap: () async => authProvider.signOut(),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text("Sign Out"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _switchButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 25,
      decoration: BoxDecoration(
          color: circleBgColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isMyCommunity = true;
                });
              },
              child: Container(
                height: 25,
                decoration: BoxDecoration(
                    color: isMyCommunity ? appColor : circleBgColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text("My Community",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              isMyCommunity ? titleColor : Color(0xffb7b2b2))),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isMyCommunity = false;
                });
              },
              child: Container(
                height: 25,
                decoration: BoxDecoration(
                    color: isMyCommunity ? circleBgColor : appColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text("Details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              isMyCommunity ? Color(0xffB7B2B2) : titleColor)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _switchResult(UserModel loggedInUser, List<Community> communityList) {
    return isMyCommunity
        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: communityList.length,
            itemBuilder: (context, index) {
              return communityList[index].ownerID == loggedInUser.id
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommunityChatScreen(
                                      community: communityList[index],
                                    ))),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 80,
                          decoration: BoxDecoration(
                            color: tileColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedImage(
                                          url: communityList[index].image),
                                    ),
                                    height: 70,
                                    width: 70,
                                  ),
                                  SizedBox(width: 5),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${communityList[index].title}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Container(
                                          width: 200,
                                          child: Text(
                                            "${communityList[index].bio}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: communitySubtitleColor,
                                            ),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: communitySubtitleColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container();
            },
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email",
                style: TextStyle(color: Color(0xffB7B2B2)),
              ),
              Container(
                padding: EdgeInsets.all(10),
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: containerColor,
                ),
                child: Text(
                  "${loggedInUser.email}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
  }
}
