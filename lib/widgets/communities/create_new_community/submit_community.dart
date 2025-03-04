import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/communities/create_new_community/create_new_community.dart';
import 'package:doodapp/shared/custom_dialog.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/communities/create_new_community/choose_community_image.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubmitCommunity extends StatefulWidget {
  final TextEditingController title;
  final TextEditingController bio;
  final Function submit;
  SubmitCommunity({
    required this.bio,
    required this.title,
    required this.submit,
  });
  @override
  _SubmitCommunityState createState() => _SubmitCommunityState();
}

class _SubmitCommunityState extends State<SubmitCommunity> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    final community = Provider.of<CommunityProvider>(context);
    return GestureDetector(
      onTap: () async {
        if (CreateNewCommunity.formKey.currentState!.validate()) {
          if (CreateNewCommunity.category == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Select a category!"),
            ));
          } else if (ChooseCommunityImage.communityImage == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Please choose an image"),
            ));
          } else {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return isLoading
                          ? GeneralLoading()
                          : AppAlertDialog(
                              title: Text(
                                "Creating a community",
                                style: TextStyle(fontSize: 21),
                              ),
                              content: Text(
                                  "Are you sure that you want to create a community?"),
                              actions: [
                                GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      try {
                                        await community.createCommunity(
                                          widget.title.text,
                                          widget.bio.text,
                                          authData.loggedInUser?.id ?? '',
                                          ChooseCommunityImage.communityImage!,
                                          authData.loggedInUser?.username ?? '',
                                          authData.loggedInUser?.email ?? '',
                                          authData.loggedInUser?.profileImage ??
                                              '',
                                          CreateNewCommunity.category!,
                                        );
                                      } catch (e) {
                                        print("Error $e");
                                        Navigator.pop(context);
                                        CreateNewCommunity
                                            .scaffoldKey.currentState!
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Cannot create community at the moment, try again later.")));
                                      }

                                      community.fetchCommunityList();
                                      Navigator.popUntil(
                                          context, (route) => route.isFirst);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Yes"),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Text("Cancel")),
                                )
                              ],
                            );
                    },
                  );
                });
          }
        }
      },
      child: Container(
        height: 50,
        color: appColor,
        child: Center(
            child: Text(
          "Create",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
