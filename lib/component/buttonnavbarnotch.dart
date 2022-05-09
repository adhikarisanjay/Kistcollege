import 'package:flutter/material.dart';
import 'package:kist/Screens/Samplearrayjson/jsonarray.dart';
import 'package:kist/Screens/homepage.dart';
import 'package:kist/Screens/samplejson/samplejson.dart';
import 'package:kist/Screens/tabpage/tabpage.dart';
import 'package:kist/component/colors.dart';
import 'package:kist/modal/samplejson.dart';

class ButtomNavBar1 extends StatefulWidget {
  const ButtomNavBar1({Key? key}) : super(key: key);

  @override
  State<ButtomNavBar1> createState() => _ButtomNavBar1State();
}

class _ButtomNavBar1State extends State<ButtomNavBar1> {
  dynamic currentpage = HomePage();
  Color color = primary;
  int currentindex = 0;
  int? index = 0;
  int? height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentpage,
        floatingActionButton: FloatingActionButton(
            backgroundColor: secondary,
            onPressed: () {},
            child: Container(
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Icon(Icons.access_alarm_sharp),
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 4,
          clipBehavior: Clip.antiAlias,
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                    // minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentindex = 0;
                        index = 0;
                        currentpage = HomePage();
                      });
                    },
                    child: columnwidget(0, Icons.home, "Home", Colors.black)),
                MaterialButton(
                    // minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentindex = 1;
                        index = 1;

                        currentpage = TabBarPage();
                      });
                    },
                    child: columnwidget(1, Icons.tab, "Tabpage", color)),
                MaterialButton(
                    // minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentindex = 2;
                        index = 2;
                        currentpage = SampleArray();
                      });
                    },
                    child: columnwidget(2, Icons.cloud_circle, "page3", color)),
                MaterialButton(
                    // minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentindex = 3;
                        currentpage = SampleJSonPage();
                      });
                    },
                    child:
                        columnwidget(3, Icons.download, "SampleJson", color)),
              ],
            ),
          ),
        ));
  }

  columnwidget(i, icon, text, primary) {
    print('$currentindex');
    return Column(
      children: [
        currentindex == i
            ? Icon(
                icon,
                color: secondary,
                size: 24,
              )
            : Icon(
                icon,
                color: color,
                size: 18,
              ),
        Text(text)
      ],
    );
  }
}
