import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/category.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier{
  final categoryCollection = FirebaseFirestore.instance.collection("categories");
  Category category;
  List<Category> categoryList;

  Future fetchCategoryList() async{
    QuerySnapshot snapshot = await categoryCollection.get();
    List<DocumentSnapshot> result = snapshot.docs;
    categoryList = [];
    result.forEach((snap) {
      category = Category(
        id: snap.data()['id'],
        title: snap.data()['title'],
        image: snap.data()['image'],
      );
      categoryList.add(category);
    });
    notifyListeners();
  }
}