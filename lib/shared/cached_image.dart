import 'package:cached_network_image/cached_network_image.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/loading/image_loading.dart';
import 'package:flutter/material.dart';


class CachedImage extends StatelessWidget {
  String url;
  bool isProfileImg;
  CachedImage({this.url, this.isProfileImg});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, loadedImage) => isProfileImg == true
      ? CircleAvatar(
        radius: 27,
        backgroundColor: appColor,
        child: CircleAvatar(
          radius: 25,
          backgroundImage: loadedImage,
        ),
        
      )
      : Image(image: loadedImage, fit: BoxFit.cover),
      placeholder: (context, url) => ImageLoading(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}