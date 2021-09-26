import 'package:doodapp/models/category.dart';
import 'package:doodapp/providers/category_provider.dart';
import 'package:doodapp/screens/communities/create_new_community/create_new_community.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseCommunityCategory extends StatefulWidget {
  @override
  _ChooseCommunityCategoryState createState() => _ChooseCommunityCategoryState();
}

class _ChooseCommunityCategoryState extends State<ChooseCommunityCategory> {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return DropdownButton<Category>(
              isExpanded: true,
              hint: Text('Select category'),
              value: CreateNewCommunity.category,
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: CreateNewCommunity.category != null ? appColor : Colors.grey,
              ),
              onChanged: (Category newValue) {
                setState(() {
                  CreateNewCommunity.category = newValue;
                });
              },
              items:
                  categoryProvider.categoryList.map<DropdownMenuItem<Category>>((Category value) {
                return DropdownMenuItem<Category>(
                  value: value,
                  child: Text(value.title),
                );
              }).toList(),
            );
          
  }
}