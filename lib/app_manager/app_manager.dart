import 'package:doodapp/providers/auth_provider.dart';
import 'package:doodapp/screens/home/home.dart';
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
  @override
    void didChangeDependencies() async{
      if(isInit){
      isInit = false;
      setState(() {
        isLoading = true;
      });
      await Provider.of<AuthProvider>(context).fetchUserData();
      setState(() {
        isLoading = false;
      });
    }else{
      setState(() {
        isLoading = false;
      });
    }
      super.didChangeDependencies();
    }
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    return isLoading
    ? HomeLoading()
    : HomeScreen();
  }
}