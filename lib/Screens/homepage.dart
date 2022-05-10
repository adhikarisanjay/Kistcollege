import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kist/Services/Apiconnectservices.dart';
import 'package:kist/Services/firebaseservices.dart';
import 'package:kist/component/drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int counter = 0;
  bool showsvg = false;
  DrawerWidget? drawer;
  @override
  void initState() {
    // TODO: implement initState
    print("debugging");
    FirbaseServices().update();
    checksharedvalue();
    drawer = DrawerWidget(callback: callbackfunction);
    super.initState();
  }

  callbackfunction(language, index) {
    print(language);
    if (index == 0) {
      context.setLocale(const Locale('en'));
    } else {
      context.setLocale(const Locale('hi'));
    }
  }

  checksharedvalue() async {
    final pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              title: Text(
            "Kist",
            style: TextStyle(color: Colors.black),
          )),
          endDrawer: DrawerWidget(
            callback: callbackfunction,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: Icon(Icons.menu))
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //if else condition
                    showsvg == true
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: SvgPicture.asset(
                              "assets/visitor.svg",
                              height: 200,
                              matchTextDirection: true,
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Image.asset("assets/download.jpeg"),
                          ),
                    Text(
                      "$counter",
                      style: TextStyle(fontSize: 25.0),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //icon button
                        ElevatedButton.icon(
                            onPressed: () {
                              //change variable
                              setState(() {
                                showsvg = true;
                                counter++;
                              });
                            },
                            icon: const Icon(Icons.add),
                            label: Text("increase".tr())),
                        ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                showsvg = false;

                                counter++;
                              });
                            },
                            icon: const Icon(Icons.remove),
                            label: const Text("Decrease")),

                        //button
                        // ElevatedButton(
                        //   style: ButtonStyle(
                        //       padding: MaterialStateProperty.all(
                        //           const EdgeInsets.symmetric(
                        //               vertical: 10, horizontal: 35)),
                        //       shape:
                        //           MaterialStateProperty.all<RoundedRectangleBorder>(
                        //               RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(20.0),
                        //       ))),
                        //   child: const Text('SEND', style: TextStyle(fontSize: 20)),
                        //   onPressed: () {},
                        // ),
                        // ElevatedButton(
                        //   style: ButtonStyle(
                        //       padding: MaterialStateProperty.all(
                        //           const EdgeInsets.symmetric(
                        //               vertical: 10, horizontal: 35)),
                        //       shape:
                        //           MaterialStateProperty.all<RoundedRectangleBorder>(
                        //               RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(20.0),
                        //       ))),
                        //   child: const Text('SEND', style: TextStyle(fontSize: 20)),
                        //   onPressed: () {},
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
