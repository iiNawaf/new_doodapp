import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/communities/create_new_community/choose_community_image.dart';
import 'package:doodapp/widgets/communities/create_new_community/community_bio.dart';
import 'package:doodapp/widgets/communities/create_new_community/community_title.dart';
import 'package:doodapp/widgets/communities/create_new_community/submit_community.dart';
import 'package:flutter/material.dart';


class CreateNewCommunity extends StatefulWidget {
  static String routeName = "/screens/communities/create_new_community.dart";
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  _CreateNewCommunityState createState() => _CreateNewCommunityState();
}

class _CreateNewCommunityState extends State<CreateNewCommunity> {
  TextEditingController communityTitleController = TextEditingController();
  TextEditingController communityBioController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() { 
    communityTitleController.clear();
    communityBioController.clear();
    ChooseCommunityImage.communityImage = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ApplicationBar(isCreateNewCommunity: true, title: "Create Community",),
      ),
      body: Form(
        key: CreateNewCommunity.formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommunityTitle(controller: communityTitleController),
              SizedBox(height: 20),
              CommunityBio(controller: communityBioController),
              SizedBox(height: 20),
              ChooseCommunityImage(),
              SizedBox(height: 30),
              SubmitCommunity(
                title: communityTitleController,
                bio: communityBioController,
              )
            ],
          ),
        ),
      ),
    );
  }
}