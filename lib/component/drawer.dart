import 'package:flutter/material.dart';
import 'package:kist/Screens/tabpage/tabpage.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
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
                  child: const Text(
                    "This is Header",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )),
          const ListTile(
            leading: Icon(Icons.home),
            title: Text(
              "Home",
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
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => TabBarPage())));
            },
            leading: Icon(Icons.home),
            title: const Text(
              "Page2",
              style: TextStyle(color: Colors.black),
            ),
            trailing: Icon(Icons.abc),
          )
        ],
      ),
    );
  }
}
