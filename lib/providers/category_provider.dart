import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/models/category.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  final categoryCollection =
      FirebaseFirestore.instance.collection("categories");
  Category? category;
  List<Category>? categoryList;

  Future<void> fetchCategoryList() async {
    try {
      QuerySnapshot snapshot = await categoryCollection.get();
      List<DocumentSnapshot> result = snapshot.docs;
      categoryList = [];

      for (var snap in result) {
        var data = snap.data();
        if (data != null && data is Map<String, dynamic>) {
          category = Category(
            id: data['id'] ?? "",
            title: data['title'] ?? "",
            image: data['image'] ?? "",
          );
          categoryList?.add(category!);
        }
      }
      notifyListeners();
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }
}
