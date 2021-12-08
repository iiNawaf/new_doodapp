import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/screens/home/home.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/loading/image_loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserImage extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  UserImage({this.scaffoldKey});
  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  bool isLoading = false;
  bool imageChanged = false;
  Future getImage(AuthProvider authData) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
          isLoading = true;
        });
    setState(() {
      HomeScreen.userImage = image;
    });
        setState(() {
          isLoading = false;
        });
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    return CachedNetworkImage(
            imageUrl: authData.loggedInUser.profileImage,
            imageBuilder: (context, url) => Stack(children: [
              CircleAvatar(
                radius: 52,
                backgroundColor: appColor,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: bgColor,
                  backgroundImage: HomeScreen.userImage != null
                      ? FileImage(HomeScreen.userImage)
                      : NetworkImage('${authData.loggedInUser.profileImage}'),
                ),
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: GestureDetector(
                  onTap: isLoading ? null : () async {
                    if (HomeScreen.userImage != null) {
                      setState(() {
                        isLoading = true;
                      });
                      await authData.updateUserImage(
                          authData.loggedInUser.id, HomeScreen.userImage);
                      setState(() {
                        isLoading = false;
                        imageChanged = true;
                      });
                    } else {
                      await getImage(authData);
                    }
                  },
                  child: imageChanged ? Container()
                  : CircleAvatar(
                    backgroundColor: appColor,
                    child: isLoading 
                    ? CircularProgressIndicator() : Icon(
                        HomeScreen.userImage != null ? Icons.done : Icons.edit,
                        color: Colors.white),
                  ),
                ),
              )
            ]),
            placeholder: (context, url) => ImageLoading(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          );
  }
}
