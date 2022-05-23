import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kist/Screens/auth/loginpage.dart';
import 'package:kist/Screens/homepage.dart';
import 'package:kist/Screens/otpbasedlogin/otppage.dart';
import 'package:kist/Screens/otpbasedlogin/phonescreen.dart';
import 'package:kist/Screens/phoneauth.dart';
import 'package:kist/component/buttonnavbar.dart';
import 'package:kist/component/buttonnavbarnotch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? loginstatus;
  @override
  void initState() {
    // TODO: implement initState

    checkloginstatus();
    super.initState();
    timer();
  }

  checkloginstatus() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      loginstatus = pref.getBool("loginstatus");
    });
  }

  timer() {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  navigationPage() {
    if (loginstatus == true) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ButtomNavBar1()),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset("assets/icon.png"),
              ),
              const CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
