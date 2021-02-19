import 'dart:io';

import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChooseCommunityImage extends StatefulWidget {
  static File communityImage;
  @override
  _ChooseCommunityImageState createState() => _ChooseCommunityImageState();
}

class _ChooseCommunityImageState extends State<ChooseCommunityImage> {
    Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      ChooseCommunityImage.communityImage = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Community Image: ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: getImage,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: appColor),
                color: Colors.white),
            child: ChooseCommunityImage.communityImage == null 
            ? Icon(Icons.add) 
            : ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.file(ChooseCommunityImage.communityImage, fit: BoxFit.fill),
              ),
            height: 80,
            width: 80,
          ),
        )
      ],
    );
  }
}
