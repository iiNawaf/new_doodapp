import 'dart:io';

import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/communities/choose_community_image.dart';
import 'package:doodapp/widgets/communities/community_bio.dart';
import 'package:doodapp/widgets/communities/community_title.dart';
import 'package:doodapp/widgets/communities/submit_community.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CreateNewCommunity extends StatefulWidget {
  static String routeName = "/screens/communities/create_new_community.dart";
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  _CreateNewCommunityState createState() => _CreateNewCommunityState();
}

class _CreateNewCommunityState extends State<CreateNewCommunity> {
  TextEditingController communityTitleController = TextEditingController();
  TextEditingController communityBioController = TextEditingController();
  

  @override
  void dispose() { 
    communityTitleController.clear();
    communityBioController.clear();
    ChooseCommunityImage.communityImage = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ApplicationBar(isCreateNewCommunity: true),
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