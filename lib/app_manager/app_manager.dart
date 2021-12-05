import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:doodapp/admin_panel/admin_panel.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/banner_provider.dart';
import 'package:doodapp/providers/category_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/providers/dood_area_provider.dart';
import 'package:doodapp/screens/discover/discover.dart';
import 'package:doodapp/screens/dood_area/dood_area.dart';
import 'package:doodapp/screens/message/message_list.dart';
import 'package:doodapp/screens/home/home.dart';
import 'package:doodapp/screens/my_profile/my_profile.dart';
import 'package:doodapp/shared/custom_dialog.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/side/appbar.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
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
  TextEditingController msgController = TextEditingController();

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
        final bannerProvider =
            Provider.of<BannerProvider>(context, listen: false);
        final doodProvider =
            Provider.of<DoodAreaProvider>(context, listen: false);
        //first, fetch user data
        await authProvider.fetchUserData();
        // then, fetch community list
        await communityProvider.fetchCommunityList();
        // fetch category list
        await categoryProvider.fetchCategoryList();
        // load banners
        await bannerProvider.loadBanners();
        // fetch doods
        await doodProvider.fetchDoods();
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
    MyProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final doodProvider = Provider.of<DoodAreaProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
        backgroundColor: selectedIndex == 2 ? bgDarkColor : bgColor,
        floatingActionButton: selectedIndex == 2
            ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return isLoading
                            ? Center(child: GeneralLoading())
                            : AppAlertDialog(
                                isDoodArea: true,
                                title: Text(
                                  "Send Dood",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: titleColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Color(0xff424242),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextField(
                                      style: TextStyle(color: titleColor),
                                      maxLength: 120,
                                      controller: msgController,
                                      decoration: InputDecoration(
                                        focusedBorder: InputBorder.none,
                                        hintText: "Type a message...",
                                        hintStyle: TextStyle(color: titleColor),
                                        counterText: "",
                                      )),
                                ),
                                actions: [
                                  isLoading
                                      ? GeneralLoading()
                                      : TextButton(
                                          onPressed: () {
                                            if (msgController.text.length > 0) {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              doodProvider.sendDood(
                                                  msgController.text,
                                                  authProvider.loggedInUser.id);
                                              Navigator.pop(context);
                                              setState(() {
                                                isLoading = false;
                                              });
                                            }
                                          },
                                          child: Text(
                                            "Submit",
                                            style: TextStyle(color: appColor),
                                          ))
                                ],
                              );
                      });
                },
                backgroundColor: Color(0xff424242),
                child: Icon(Icons.add),
              )
            : Container(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
        bottomNavigationBar: isLoading
            ? HomeLoading()
            : Container(
                height: 100,
                child: BubbleBottomBar(
                  opacity: .2,
                  backgroundColor:
                      selectedIndex == 2 ? Color(0xff303030) : appColor,
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
