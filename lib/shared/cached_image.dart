import 'package:cached_network_image/cached_network_image.dart';
import 'package:doodapp/widgets/loading/image_loading.dart';
import 'package:flutter/material.dart';


class CachedImage extends StatelessWidget {
  String url;
  CachedImage({this.url});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, loadedImage) => Image(image: loadedImage, fit: BoxFit.cover),
      placeholder: (context, url) => ImageLoading(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}