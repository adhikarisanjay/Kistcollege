import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:kist/Screens/auth/loginpage.dart';
import 'package:kist/Screens/tabpage/tabpage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  final Function? callback;
  const DrawerWidget({Key? key, this.callback}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int selectedindex = 0;

  @override
  void initState() {
    super.initState();
    getsharedvalue();
  }

  getsharedvalue() async {
    final pref = await SharedPreferences.getInstance();
    int? indexvalue = pref.getInt("lngindex");
    print("index= $indexvalue");

    if (indexvalue != null || indexvalue != '') {
      setState(() {
        selectedindex = indexvalue!;
      });
    }
  }

  storevariables(index) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("lngindex", index);
    // context.setLocale(const Locale('hi'));

    if (index == 0) {
      context.setLocale(const Locale('en'));
      widget.callback!("en", index);
    } else {
      context.setLocale(const Locale('hi'));
      widget.callback!("hi", index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              padding: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Container(
                  color: Colors.blueGrey,
                  height: 20,
                  child: Center(
                    child: FlutterToggleTab(
                      // width in percent, to set full width just set to 100
                      width: 50,
                      borderRadius: 30,
                      height: 40,
                      selectedIndex: selectedindex,

                      selectedTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      unSelectedTextStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      labels: const ["English", "नेपाली"],
                      selectedLabelIndex: (index) {
                        setState(() {
                          selectedindex = index;
                          storevariables(index);
                        });
                        print("Selected Index $index");
                      },
                    ),
                  ),
                ),
              )),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              "homepage".tr(),
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(Icons.abc),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) => TabBarPage()),
              //     (route) => false);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const TabBarPage(
                            title: "Page2",
                          ))));
            },
            leading: Icon(Icons.home),
            title: const Text(
              "Page2",
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(Icons.abc),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);

              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const LoginPage())));
            },
            leading: Icon(Icons.login),
            title: const Text(
              "Login",
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(Icons.abc),
          )
        ],
      ),
    );
  }
}
