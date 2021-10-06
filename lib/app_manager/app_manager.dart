import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/banner_provider.dart';
import 'package:doodapp/providers/category_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/screens/discover/discover.dart';
import 'package:doodapp/screens/dood_area/dood_area.dart';
import 'package:doodapp/screens/message/message_list.dart';
import 'package:doodapp/screens/home/home.dart';
import 'package:doodapp/screens/my_profile/my_profile.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/side/appbar.dart';
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
        final categoryProvider =
            Provider.of<CategoryProvider>(context, listen: false);
        final bannerProvider = Provider.of<BannerProvider>(context);
        //first, fetch user data
        await authProvider.fetchUserData();
        // then, fetch community list
        await communityProvider.fetchCommunityList();
        // fetch category list
        await categoryProvider.fetchCategoryList();
        // load banners
        await bannerProvider.loadBanners();
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

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> screens = [
    HomeScreen(),
    MessageListScreen(),
    DoodAreaScreen(),
    DiscoverScreen(),
    MyProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedIndex == 2 ? bgDarkColor : bgColor,
        appBar: isLoading
            ? AppBar()
            : PreferredSize(
                preferredSize: Size.fromHeight(65),
                child: ApplicationBar(
                  selectedIndex: selectedIndex,
                  isAppManager: true,
                  title: selectedIndex == 0
                      ? "Home"
                      : selectedIndex == 1
                          ? "Messages"
                          : selectedIndex == 2
                              ? "DoodArea"
                              : selectedIndex == 3
                                  ? "Discover"
                                  : "Profile",
                ),
              ),
        bottomNavigationBar: Container(
          height: 100,
          child: BubbleBottomBar(
            opacity: .2,
            backgroundColor: selectedIndex == 2 ? Color(0xff303030) : appColor,
            currentIndex: selectedIndex,
            onTap:
                _onItemTapped, //border radius doesn't work when the notch is enabled.
            elevation: 0,
            items: [
              navItem("Home", './assets/icons/home.png'),
              navItem("Messages", './assets/icons/message.png'),
              navItem("DoodArea", './assets/icons/incognito.png'),
              navItem("Discover", './assets/icons/compass.png'),
              navItem("My Profile", './assets/icons/profile_icon.png'),
            ],
          ),
        ),
        body: isLoading ? HomeLoading() : screens.elementAt(selectedIndex));
  }

  BubbleBottomBarItem navItem(String title, String img) {
    return BubbleBottomBarItem(
        backgroundColor: Color(0xffffffff),
        icon: Image.asset(img),
        activeIcon: Image.asset(img),
        title: Text(title));
  }
}
