
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jhunt/screens/home_page.dart';
import 'package:jhunt/screens/home_screen.dart';
import 'package:jhunt/screens/screens.dart';
import 'package:jhunt/screens/sign_google.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Image.asset("assets/j3.png")),
       /* decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/j3.png"),
              fit: BoxFit.cover),
        ),*/
      ),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    print(status);
    if (status) {
    Navigator.of(context).pushNamed(HomeScreen.homeScreen);
    } else {
      Navigator.pushNamed(context, SignIn.signIn);
    }
  }
}