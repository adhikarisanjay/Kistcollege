import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kist/Screens/Samplearrayjson/jsonarray.dart';
import 'package:kist/Screens/categoryhomepage/homepagecat.dart';
import 'package:kist/Screens/homepage.dart';
import 'package:kist/Screens/phoneauth.dart';
import 'package:kist/Screens/samplejson/samplejson.dart';
import 'package:kist/Screens/tabpage/tabpage.dart';
import 'package:kist/component/colors.dart';
import 'package:kist/main.dart';
import 'package:kist/modal/samplejson.dart';

class ButtomNavBar1 extends StatefulWidget {
  const ButtomNavBar1({Key? key}) : super(key: key);

  @override
  State<ButtomNavBar1> createState() => _ButtomNavBar1State();
}

class _ButtomNavBar1State extends State<ButtomNavBar1> {
  @override
  void initState() {
    super.initState();
    firebasenotifcation();
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
                // color: Colors.red,
                playSound: false,
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
      print("notification: ${message.notification?.title}");
      print("onMessage: ${message.notification?.body}");

      if (message.notification?.title != null) {
        alertbox(message.notification?.title, message.notification?.body);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('background   ${message}');

      RemoteNotification? notification = message.notification;

      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        // alertbox(message.notification?.title, message.notification?.title);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  devicekey() async {
    await FirebaseMessaging.instance
        .getToken()
        .then((token) => {print("devicetoken$token")});
  }

  dynamic currentpage = CatHomepage();
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
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                    // minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentindex = 0;
                        index = 0;
                        currentpage = CatHomepage();
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

  alertbox(title, body) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
