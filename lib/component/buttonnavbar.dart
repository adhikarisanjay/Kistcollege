import 'package:flutter/material.dart';
import 'package:kist/Screens/homepage.dart';
import 'package:kist/Screens/tabpage/tabpage.dart';

class ButtonNavBar extends StatefulWidget {
  const ButtonNavBar({Key? key}) : super(key: key);

  @override
  State<ButtonNavBar> createState() => _ButtonNavBarState();
}

class _ButtonNavBarState extends State<ButtonNavBar> {
  dynamic currentpage = HomePage();
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: currentpage,
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tab),
              label: 'page2',
              backgroundColor: Colors.red,
            ),
          ],
          selectedItemColor: Color.fromRGBO(255, 143, 0, 1),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        currentpage = TabBarPage();
      } else {
        currentpage = HomePage();
      }
    });
    print(index);
  }
}
