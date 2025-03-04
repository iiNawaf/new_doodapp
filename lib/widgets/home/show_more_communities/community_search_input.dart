import 'package:doodapp/shared/utilities.dart';
import 'package:flutter/material.dart';

class CommunitySearchInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? search;
  CommunitySearchInput({required this.controller, this.search});
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
            color: containerColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: TextField(
            cursorColor: Colors.grey,
            controller: widget.controller,
            onChanged: widget.search,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 8),
                prefixIcon: Icon(Icons.search, color: iconColor),
                hintText: "Search for community...",
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
