import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/banner.dart';
import 'package:flutter/material.dart';

class BannerProvider extends ChangeNotifier{
  final bannerCollection = FirebaseFirestore.instance.collection('banner');
BannerModel banner;
List<BannerModel> bannerList;

Future<void> loadBanners() async{
  try{
    QuerySnapshot snapshot = await bannerCollection.get();
  List<DocumentSnapshot> result = snapshot.docs;
  bannerList = [];
  result.forEach((snap) { 
    banner = BannerModel(
      url: snap.data()['image_url'],
      link: snap.data()['link'],
    );
    bannerList.add(banner);
  });
  notifyListeners();
  }catch(e){
    print("Banner error $e");
  }
}
}