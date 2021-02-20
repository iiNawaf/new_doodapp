import 'package:cached_network_image/cached_network_image.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/loading/image_loading.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  String image;
  UserImage({this.image});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, url) => Stack(children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage('$image'),
        ),
        Positioned(
          bottom: 1,
          right: 1,
          child: CircleAvatar(
          backgroundColor: appColor,
          child: Icon(Icons.edit, color: Colors.white),
        ),
        )
      ]),
      placeholder: (context, url) => ImageLoading(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
