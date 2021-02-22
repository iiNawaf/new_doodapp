import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/live_chat.dart';
import 'package:doodapp/providers/reports_provider.dart';
import 'package:doodapp/screens/live_chat/live_chat.dart';
import 'package:doodapp/shared/custom_dialog.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ReportChat extends StatefulWidget {
  LiveChat liveChat;
  ReportChat({this.liveChat});
  @override
  _ReportChatState createState() => _ReportChatState();
}

class _ReportChatState extends State<ReportChat> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final rp = Provider.of<ReportsProvider>(context);
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                    onTap: () async {
                      showDialog(
                        barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return isLoading ? GeneralLoading() 
                              : AppAlertDialog(
                                title: Text("Report User",
                                    style: TextStyle(fontSize: 19)),
                                content: Text("Are you sure you want to report this user?"),
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await rp.submitLiveChatReport(
                                            widget.liveChat.senderID,
                                            widget.liveChat.senderUsername,
                                            widget.liveChat.message,
                                          );
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.pop(context);
                                          LiveChatScreen.scaffoldKey.currentState.showSnackBar(
                                            SnackBar(content: Text("User successfully reported!"),)
                                          );
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
                    },
                    child: CircleAvatar(
                      backgroundColor: appColor,
                      child: Icon(Icons.flag, color: Colors.white),
                    )),
              );
  }
}