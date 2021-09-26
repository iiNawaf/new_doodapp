import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomeCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            initialPage: 0,
            indicatorColor: appColor,
            indicatorBackgroundColor: subtextColor,
            isLoop: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "https://www.cdc.gov/wcms/4.0/cdc-wp/sample-pages/images/banner4-710x330.jpg",
                    fit: BoxFit.fill,
                    ),
                ),
              )
            ],
          ),
        );
  }
}
