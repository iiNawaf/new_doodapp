import 'package:cached_network_image/cached_network_image.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/loading/image_loading.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String? url;
  final bool? isProfileImg;
  final bool? isCommunityImg;
  final bool? isIcon;
  final double? radius;
  CachedImage(
      {this.url,
      this.isProfileImg,
      this.isCommunityImg,
      this.isIcon,
      this.radius});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? '',
      imageBuilder: (context, loadedImage) => isProfileImg == true
          ? CircleAvatar(
              radius: radius,
              backgroundColor: appColor,
              backgroundImage: loadedImage,
            )
          : isCommunityImg == true
              ? Container(
                  height: 260,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(image: loadedImage, fit: BoxFit.fill),
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
              : ImageLoading(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
