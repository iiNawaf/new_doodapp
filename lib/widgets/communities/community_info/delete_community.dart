import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/shared/custom_dialog.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteCommunity extends StatefulWidget {
  final Community? community;
  final Function? submit;
  DeleteCommunity({this.community, this.submit});

  @override
  _DeleteCommunityState createState() => _DeleteCommunityState();
}

class _DeleteCommunityState extends State<DeleteCommunity> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<CommunityProvider>(context);
    return GestureDetector(
      onTap: () => submitDelete(context, cp),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          color: appColor,
          child: Center(
            child: Text(
              "Delete",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  void submitDelete(context, CommunityProvider cp) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return isLoading
                    ? GeneralLoading()
                    : AppAlertDialog(
                        title: Text(
                          "Delete ${widget.community?.title}",
                          style: TextStyle(fontSize: 21),
                        ),
                        content: Text(
                            "Are you sure you want to delete your community? "),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await cp.deleteCommunity(
                                    widget.community?.id ?? '',
                                  );

                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                },
                                child: Text("Yes")),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Text("Cancel"),
                            ),
                          ),
                        ],
                      );
              },
            ));
  }
}
