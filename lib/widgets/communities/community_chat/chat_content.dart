import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/reports_provider.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/shared/custom_dialog.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ChatContent extends StatefulWidget {
  CommunityChat communityChat;
  Community community;
  ChatContent({this.communityChat, this.community});

  @override
  _ChatContentState createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  String formatTimestamp(Timestamp timestamp) {
    try {
      var format = new DateFormat('d MMM, hh:mm a');
      var date = timestamp.toDate();
      return format.format(date);
    } catch (e) {
      return "Sending...";
    }
  }

  bool isSender(AuthProvider authProvider) {
    if (authProvider.loggedInUser.id == widget.communityChat.senderID) {
      return true;
    } else {
      return false;
    }
  }

  bool isBlocked(AuthProvider ap, CommunityChat chat){
    for(int i = 0; i < ap.loggedInUser.blockedUsers.length; i++){
      if(ap.loggedInUser.blockedUsers[i] == chat.senderID){
        return true;
      }else{
        return false;
      }
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    final rp = Provider.of<ReportsProvider>(context);
    return widget.community.id == widget.communityChat.communityID
        ? Row(
            children: [
              Expanded(
                child: isBlocked(authData, widget.communityChat) == true
              ? Container(padding: EdgeInsets.all(15), decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[300], ), child: Text("Blocked User") ,)
              : Column(
                    crossAxisAlignment: authData.loggedInUser.id ==
                            widget.communityChat.senderID
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      !isSender(authData)
                          ? Text(
                              "${widget.communityChat.sender}",
                              style: TextStyle(
                                  color: titleBlackColor,
                                  height: 1,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          : Container(),
                      Container(
                        padding: EdgeInsets.only(
                            left: 8, top: 5, bottom: 5, right: 8),
                        decoration: BoxDecoration(
                            color: isSender(authData)
                                ? appColor
                                : appColor.withOpacity(0.4),
                            borderRadius: isSender(authData)
                                ? BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  )
                                : BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  )),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height: 8),
                              Text(
                                "${widget.communityChat.content}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${formatTimestamp(widget.communityChat.timestamp)}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ]),
                      ),
                    ]),
              ),
              widget.communityChat.senderID != authData.loggedInUser.id
                  ? IconButton(
                      onPressed: () => showOptions(rp, authData, widget.communityChat),
                      icon: Icon(Icons.more_horiz))
                  : Container(),
            ],
          )
        : Container();
  }

  void showOptions(ReportsProvider rp, AuthProvider ap, CommunityChat chat) {
    showDialog(
        context: context,
        builder: (context) {
          return AppAlertDialog(
            title: Text("Message Options", style: TextStyle(fontSize: 16)),
            content: Text("Choose an action"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    reportDialog(rp);
                  },
                  child: Text(
                    "Report",
                    style: TextStyle(color: titleBlackColor),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    blockUser(ap, chat);
                  },
                  child: Text(
                    isBlocked(ap, chat) == true ? "Unblock User" : "Block User",
                    style: TextStyle(color: titleBlackColor),
                  )),
            ],
          );
        });
  }

  void reportDialog(ReportsProvider rp) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return isLoading
                ? GeneralLoading()
                : AppAlertDialog(
                    title: Text("Report User", style: TextStyle(fontSize: 19)),
                    content: Text("Are you sure you want to report this user?"),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await rp.submitCommunityChatReport(
                                widget.communityChat.communityID,
                                widget.communityChat.senderID,
                                widget.communityChat.sender,
                                widget.communityChat.content,
                              );
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pop(context);
                            
                            },
                            child: Text("Yes")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text("No")),
                      )
                    ],
                  );
          });
        });
  }

  void blockUser(AuthProvider ap, CommunityChat chat) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return isLoading
                ? GeneralLoading()
                : AppAlertDialog(
                    title: Text(isBlocked(ap, chat) == true ? "Unblock User" : "Block User", style: TextStyle(fontSize: 19)),
                    content: Text("Confirm action?"),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              if(isBlocked(ap, chat) == true){
                                await ap.unBlockUser(ap.loggedInUser.id, chat.senderID);
                              }else{
                                await ap.blockUser(ap.loggedInUser.id, chat.senderID);
                              }
                              
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pop(context);
                              
                            },
                            child: Text("Yes")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text("No")),
                      )
                    ],
                  );
          });
        });
  }
}
