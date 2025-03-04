import 'package:doodapp/providers/banner_provider.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBanner extends StatelessWidget {
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final banner = Provider.of<BannerProvider>(context);
    return Container(
      child: ImageSlideshow(
          width: double.infinity,
          height: 200,
          initialPage: 0,
          indicatorColor: appColor,
          indicatorBackgroundColor: subtextColor,
          isLoop: true,
          children: banner.bannerList!.map((e) {
            return Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: GestureDetector(
                onTap: () => _launchInBrowser(e.link),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "${e.url}",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          }).toList()),
    );
  }
}
