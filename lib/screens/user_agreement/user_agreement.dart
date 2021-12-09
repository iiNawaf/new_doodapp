import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAgreementScreen extends StatefulWidget {
  @override
  _UserAgreementScreenState createState() => _UserAgreementScreenState();
}

class _UserAgreementScreenState extends State<UserAgreementScreen> {
  bool didAgree = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User Agreement",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),

              Text("DoodApp is a social app which allows people to communicate with people having the same interests. This agreement is to save the users rights and to make the app an appropriate platform for communication."),

              Text(
                "Terms of use",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text("In DoodApp, abusive content and sexual harrasments are not allowed and any action will be considered by the admin immediately. You can help us improve the app by reporting abusive people. Also notice that DoodApp is only eligible for adults."),

              Text(
                "Collecting information",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text("DoodApp does not collect any personal information about the users. The purpose of this app is for people to communicate and meet new people."),

          
              // Checkbox
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: appColor,
                    value: didAgree,
                    onChanged: (bool value) {
                      setState(() {
                        didAgree = value;
                      });
                    },
                  ),
                  Container(
                      width: 300,
                      child: Text(
                        "I have read and understand the terms and want to continue.",
                        style: TextStyle(height: 1.2),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: // Agree Button
          Padding(
            padding: const EdgeInsets.only(top:15, bottom: 30, left: 15, right: 15),
            child: isLoading ? GeneralLoading() 
            : GestureDetector(
              onTap: () async{
                setState(() {
                  isLoading = true;
                });
                await authProvider.agreeTerms(authProvider.loggedInUser.id);
                setState(() {
                  isLoading = false;
                });
              },
        child: Container(
            height: 50,
            color: didAgree ? appColor : Colors.grey,
            child: Center(
              child: Text(
                "Accept",
                style: TextStyle(
                    color: titleColor, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
        ),
      ),
          ),
    );
  }
}
