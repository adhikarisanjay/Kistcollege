import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kist/Screens/homepage.dart';
import 'package:kist/Screens/tabpage/tabpage.dart';
import 'package:kist/main.dart';
import 'package:kist/modal/samplejson.dart';

class ButtonNavBar extends StatefulWidget {
  const ButtonNavBar({Key? key}) : super(key: key);

  @override
  State<ButtonNavBar> createState() => _ButtonNavBarState();
}

class _ButtonNavBarState extends State<ButtonNavBar> {
  @override
  void initState() {
    super.initState();
    // firebasenotifcation();
    devicekey();
  }

  firebasenotifcation() {
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;

      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                color: Colors.red,
                playSound: true,
                // subText: channel.description,
                enableVibration: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: ${message.category}");
      print("onMessage: ${message.data}");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      print('f   ${notification?.body}');

      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {}
    });
  }

  devicekey() async {
    await FirebaseMessaging.instance
        .getToken()
        .then((token) => {print("devicetoken$token")});
  }

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
      } else if (index == 2) {
        setState(() {
          currentpage = SampleJson();
        });
      } else {
        currentpage = HomePage();
      }
    });
    print(index);
  }
}
