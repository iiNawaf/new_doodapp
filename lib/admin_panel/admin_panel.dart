import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/reports_provider.dart';
import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    final rp = Provider.of<ReportsProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: ApplicationBar(),
      ),
      body: authData.loggedInUser.accountType != "admin"
      ? Center(child: Text("Unauthorized access!"),) 
      : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Community Chat Reports", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            Expanded(
              child: StreamBuilder(
          stream: rp.communityChatReportsCollection.where("status", isEqualTo: "not_solved").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) return GeneralLoading();
            if(!snapshot.hasData) return Center(child: Text("No data"),);
            return ListView(
              children: snapshot.data.docs.map((documents){
                return Card(
                  child: ListTile(
                    title: Text("${documents.data()['sender_username']}"),
                    subtitle: Text("${documents.data()['content_message']}"),
                    trailing: RaisedButton(
                      child: Text("Block"),
                      onPressed: () async{
                        await rp.blockUserFromCommunityChat(
                          documents.data()['sender_id'],
                          documents.id
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
            ),
            Text("Live Chat Reports", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            Expanded(
              child: StreamBuilder(
          stream: rp.liveChatReportsCollection.where("status", isEqualTo: "not_solved").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) return GeneralLoading();
            if(!snapshot.hasData) return Text("No data");
            return ListView(
              children: snapshot.data.docs.map((documents){
                return Card(
                  child: ListTile(
                    title: Text("${documents.data()['sender_username']}"),
                    subtitle: Text("${documents.data()['content_message']}"),
                    trailing: RaisedButton(
                      child: Text("Block"),
                      onPressed: () async{
                        await rp.blockUserFromLiveChat(
                          documents.data()['sender_id'],
                          documents.id
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
            )
          ],
        ),
      )
    );
  }
}