import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/live_chat.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/live_chat_provider.dart';
import 'package:doodapp/providers/reports_provider.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/live_chat/report_chat.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:doodapp/widgets/loading/image_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class LiveChatList extends StatelessWidget {
  String formatTimestamp(Timestamp timestamp) {
    try {
      var format = new DateFormat('d MMM, hh:mm a');
      var date = timestamp.toDate();
      return format.format(date);
    } catch (e) {
      return "Sending...";
    }
  }

  bool isSender(int index, AsyncSnapshot<List<LiveChat>> snapshot,
      AuthProvider authData) {
    if (authData.loggedInUser.id == snapshot.data[index].senderID) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final liveChatProvider = Provider.of<LiveChatProvider>(context);
    final authData = Provider.of<AuthProvider>(context);
    final cp = Provider.of<ReportsProvider>(context);
    return StreamBuilder<List<LiveChat>>(
      stream: liveChatProvider.loadLiveChat,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return GeneralLoading();
        if (!snapshot.hasData) return Text("No messages!");
        return ListView.builder(
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  isSender(index, snapshot, authData) ?
                  CachedNetworkImage(
                    imageUrl: snapshot.data[index].senderImage,
                    imageBuilder: (context, loadedImage) => CircleAvatar(
                      radius: 25,
                      backgroundImage: loadedImage,
                    ),
                    placeholder: (context, url) => ImageLoading(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ) : ReportChat(liveChat: snapshot.data[index]),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: isSender(index, snapshot, authData)
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: isSender(index, snapshot, authData)
                                    ? appColor
                                    : appColor.withOpacity(0.4),
                                borderRadius: isSender(index, snapshot, authData)
                                    ? BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )
                                    : BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      )),
                            child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          isSender(index, snapshot, authData)
                                              ? CrossAxisAlignment.start
                                              : CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          isSender(index, snapshot, authData)
                                              ? "You"
                                              : "${snapshot.data[index].senderUsername}",
                                          style: TextStyle(
                                              color: isSender(index, snapshot, authData)
                                                  ? Colors.yellow[800]
                                                  : appColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "${snapshot.data[index].message}",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 15),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "${formatTimestamp(snapshot.data[index].timestamp)}",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ]),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  !isSender(index, snapshot, authData) ?
                  CachedNetworkImage(
                    imageUrl: snapshot.data[index].senderImage,
                    imageBuilder: (context, loadedImage) => CircleAvatar(
                      radius: 25,
                      backgroundImage: loadedImage,
                    ),
                    placeholder: (context, url) => ImageLoading(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ) : Container(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
