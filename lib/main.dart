import 'package:connectivity/connectivity.dart';
import 'package:doodapp/app_manager/app_manager.dart';
import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/banner_provider.dart';
import 'package:doodapp/providers/category_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/providers/dood_area_provider.dart';
import 'package:doodapp/providers/reports_provider.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/screens/communities/create_new_community/create_new_community.dart';
import 'package:doodapp/screens/home/all_communities.dart';
import 'package:doodapp/screens/wrapper/auth_wrapper.dart';
import 'package:doodapp/screens/home/home.dart';
import 'package:doodapp/screens/registration/sign_in.dart';
import 'package:doodapp/screens/registration/sign_up.dart';
import 'package:doodapp/shared/utilities.dart';
import 'package:doodapp/widgets/loading/general_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CommunityProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ReportsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CategoryProvider()
          ),
          ChangeNotifierProvider.value(
          value: BannerProvider()
          ),
          ChangeNotifierProvider.value(
          value: DoodAreaProvider()
          ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'Cairo',
                primaryIconTheme: IconThemeData(color: Color(0xff000000)),
                primaryColor: appColor,
                scaffoldBackgroundColor: bgColor,
                iconTheme: IconThemeData(color: Colors.pink),
                appBarTheme: AppBarTheme(
                  elevation: 0,
                  backgroundColor: bgColor,
                ),
                textTheme: TextTheme(
                  headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                  body1: TextStyle(color: Colors.black),
                ),
                inputDecorationTheme: InputDecorationTheme(
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: inputLabelColor),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: appColor)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: appColor)))),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale("en", "US"),
              Locale("ar", "AE"),
            ],
            locale: Locale("en", "US"),
            routes: {
              AuthWrapper.routeName: (context) => AuthWrapper(),
              HomeScreen.routeName: (context) => HomeScreen(),
              SignInScreen.routeName: (context) => SignInScreen(),
              SignUpScreen.routeName: (context) => SignUpScreen(),
              CreateNewCommunity.routeName: (context) => CreateNewCommunity(),
              AllCommunitiesScreen.routeName: (context) => AllCommunitiesScreen(),
              CommunityChatScreen.routeName: (context) => CommunityChatScreen(),
            },
            home: FutureBuilder<ConnectivityResult>(
              future: _buildAppStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return GeneralLoading();
                if (!snapshot.hasData) return Center(child: Text("No data"));
                return snapshot.data == ConnectivityResult.none
                    ? Scaffold(
                      body: Center(
                          child: Text("No network connection."),
                        ),
                    )
                    : AuthWrapper();
              },
            )),
      ),
    );
  }
}

Future<ConnectivityResult> _buildAppStatus() async {
  return await Connectivity().checkConnectivity();
}
