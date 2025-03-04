import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/banner.dart';
import 'package:flutter/material.dart';

class BannerProvider extends ChangeNotifier {
  final bannerCollection = FirebaseFirestore.instance.collection('banner');
  BannerModel? banner;
  List<BannerModel>? bannerList;

  Future<void> loadBanners() async {
    try {
      QuerySnapshot snapshot = await bannerCollection.get();
      List<DocumentSnapshot> result = snapshot.docs;
      bannerList = [];

      for (var snap in result) {
        var data = snap.data();
        if (data != null && data is Map<String, dynamic>) {
          banner = BannerModel(
            url: data['image_url'] ?? "", // Default empty string to avoid null
            link: data['link'] ?? "", // Default empty string
          );
          bannerList?.add(banner!);
        }
      }
      notifyListeners();
    } catch (e) {
      print("Banner error: $e");
    }
  }
}
