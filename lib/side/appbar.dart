import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/screens/communities/create_new_community.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationBar extends StatelessWidget {
  bool isHome;
  bool isCreateNewCommunity;
  ApplicationBar({this.isHome, this.isCreateNewCommunity});
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    return AppBar(
      elevation: 0,
      title: Text(isHome == true
          ? "Dood" ?? ""
          : isCreateNewCommunity == true
              ? "Create Community" ?? ""
              : "" ?? ""),
      leading: isHome == true
          ? IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async => await authData.signOut(),
            )
          : null,
      actions: [
        isHome == true
            ? IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, CreateNewCommunity.routeName),
                icon: Icon(Icons.add, size: 29),
              )
            : Container()
      ],
    );
  }
}
