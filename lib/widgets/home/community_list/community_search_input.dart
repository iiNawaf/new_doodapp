import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';

class CommunitySearchInput extends StatefulWidget {
  TextEditingController controller;
  Function search;
  CommunitySearchInput({this.controller, this.search});
  @override
  _CommunitySearchInputState createState() => _CommunitySearchInputState();
}

class _CommunitySearchInputState extends State<CommunitySearchInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: appColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)
        ),
        child: TextField(
          controller: widget.controller,
          onChanged: widget.search,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(Icons.search),
            hintText: "Search for community...",
            border: InputBorder.none
          ),
        ),
      ),
    );
  }
}
