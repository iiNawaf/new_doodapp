import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/home/home.dart';
import 'package:doodapp/screens/live_chat/live_chat.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/loading/home_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppManager extends StatefulWidget {
  @override
  _AppManagerState createState() => _AppManagerState();
}

class _AppManagerState extends State<AppManager> {
  bool isInit = true;
  bool isLoading = false;
  int selectedIndex = 0;
  @override
  void didChangeDependencies() async {
    try {
      if (isInit) {
        isInit = false;
        setState(() {
          isLoading = true;
        });
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final communityProvider =
            Provider.of<CommunityProvider>(context, listen: false);
        //first, fetch user data
        await authProvider.fetchUserData();
        // then, fetch community list
        await communityProvider.fetchCommunityList();
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
    super.didChangeDependencies();
  }

  void _onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> screens = [
    HomeScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: subtextColor, width: 1)
          )
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: bgColor,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              backgroundColor: bgColor,
              title: Text(""),
              icon: Image.asset('./assets/images/home.png', height: 25),
            ),
            BottomNavigationBarItem(
              title: Text(""),
              icon: Image.asset('./assets/images/message.png', height: 25)
            ),
            BottomNavigationBarItem(
              title: Text(""),
              icon: Image.asset('./assets/images/compass.png', height: 25)
            ),
            BottomNavigationBarItem(
              title: Text(""),
              icon: Image.asset('./assets/images/settings.png', height: 25)
            ),
            
          ]
        ),
      ),
      body: isLoading
          ? HomeLoading()
          : screens.elementAt(selectedIndex)
    );
  }
}
