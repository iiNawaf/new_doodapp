import 'package:doodapp/models/community.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MembersList extends StatelessWidget {
  List<CommunityMember> members;
  Community community;
  MembersList({this.members, this.community});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: members.length,
      itemBuilder: (context, index) {
        members.sort((a, b) => a.uid.compareTo(b.uid));
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage('${members[index].profileImage}'),
            ),
            title: Text("${members[index].username}"),
            trailing: community.ownerID == members[index].uid
                ? Image.asset('./assets/images/crown.png',
                    color: Colors.yellow[800], height: 25)
                : Icon(Icons.person),
          ),
        );
      },
    );
  }
}
