import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kist/Screens/homepage.dart';
import 'package:kist/component/buttonnavbar.dart';
import 'package:kist/component/buttonnavbarnotch.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }

  timer() {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  navigationPage() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => ButtomNavBar1()),
        (route) => false);
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
