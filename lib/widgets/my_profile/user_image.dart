import 'package:doodapp/shared/cached_image.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  String imgUrl;
  UserImage({this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return CachedImage(url: imgUrl, isProfileImg: true, radius: 50);
  }
}