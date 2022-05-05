import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kist/component/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;
  bool showsvg = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Kist",
          style: TextStyle(color: Colors.black),
        )),
        endDrawer: DrawerWidget(),
        body: Center(
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
                      label: const Text("Increase")),
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
        ));
  }
}
