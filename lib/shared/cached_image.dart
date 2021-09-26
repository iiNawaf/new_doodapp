import 'package:cached_network_image/cached_network_image.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/loading/image_loading.dart';
import 'package:flutter/material.dart';


class CachedImage extends StatelessWidget {
  String url;
  bool isProfileImg;
  bool isCommunityImg;
  bool isIcon;
  CachedImage({this.url, this.isProfileImg, this.isCommunityImg, this.isIcon});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, loadedImage) => isProfileImg == true
      ? CircleAvatar(
        radius: 25,
        backgroundColor: appColor,
        backgroundImage: loadedImage,       
      )
      : isCommunityImg == true
      ? Container(
        height: 250,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(url, fit: BoxFit.fill,),
        ),
      )
      : Image(image: loadedImage, fit: BoxFit.cover),
      placeholder: (context, url) => isCommunityImg == true 
      ? Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: subtitleColor,
        ),
      )
      : isIcon == true 
      ? Container()
      : ImageLoading()  ,
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}