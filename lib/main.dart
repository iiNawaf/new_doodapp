import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/providers/community_provider.dart';
import 'package:doodapp/providers/live_chat_provider.dart';
import 'package:doodapp/screens/communities/community_chat/community_chat.dart';
import 'package:doodapp/screens/communities/create_new_community/create_new_community.dart';
import 'package:doodapp/screens/home/all_communities.dart';
import 'package:doodapp/screens/wrapper/auth_wrapper.dart';
import 'package:doodapp/screens/home/home.dart';
import 'package:doodapp/screens/registration/sign_in.dart';
import 'package:doodapp/screens/registration/sign_up.dart';
import 'package:doodapp/shared/utilities.dart';
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
          value: LiveChatProvider(),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Cairo',
              primaryColor: appColor,
              cursorColor: Colors.grey,
              scaffoldBackgroundColor: Color(0xffd9d9d9),
              iconTheme: IconThemeData(color: Colors.pink),
              appBarTheme: AppBarTheme(
                elevation: 0,
              ),
              textTheme: TextTheme(
                headline:
                    TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                body1: TextStyle(color: Colors.black),
              ),
            ),
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
              HomeScreen.routeName: (context) => HomeScreen(),
              SignInScreen.routeName: (context) => SignInScreen(),
              SignUpScreen.routeName: (context) => SignUpScreen(),
              CreateNewCommunity.routeName: (context) => CreateNewCommunity(),
              AllCommunitiesScreen.routeName: (context) =>
                  AllCommunitiesScreen(),
              CommunityChatScreen.routeName: (context) => CommunityChatScreen(),
            },
            home: AuthWrapper()),
      ),
    );
  }
}
