import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/communities/create_new_community.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/communities/choose_community_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubmitCommunity extends StatelessWidget {
  TextEditingController title;
  TextEditingController bio;
  SubmitCommunity({this.bio, this.title});
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    final community = Provider.of<CommunityProvider>(context);
    return GestureDetector(
      onTap: () async{
        if(CreateNewCommunity.formKey.currentState.validate()){
          await community.createCommunity(title.text, bio.text, authData.loggedInUser.id, ChooseCommunityImage.communityImage);
          Navigator.pop(context);
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
