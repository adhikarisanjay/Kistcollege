import 'package:flutter/material.dart';
import 'package:kist/Screens/homepage.dart';
import 'package:kist/Screens/splashscreen/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kist test project",
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.red)),
        primarySwatch: Colors.blue,
      ),
    );
  }
}
